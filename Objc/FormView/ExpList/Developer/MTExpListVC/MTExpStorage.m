//
//  MTExpStorage.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/19.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//

#import "MTExpStorage.h"

#import "MTExpListCell.h"

#import "MTExpFileMonitor.h"
#import "MTTableDataSource.h"

@interface MTExpStorage() <MTExpFileMonitorDelegate>

@property (nonatomic, copy) NSString *wujiPath;

/// 本地存储的实验配置（添加或者修改的）
@property (nonatomic, strong) NSDictionary *wujiCache;

@property (nonatomic, strong) NSDictionary *configCache;

@property (nonatomic, copy) NSString *configCachePath;

@property (nonatomic, strong) NSDictionary *disguisedCache;

@property (nonatomic, strong) MTExpFileMonitor *monitor;

@property (nonatomic, strong) dispatch_semaphore_t lock;

@end


// MTExpStorage
@implementation MTExpStorage

+ (instancetype)sharedInstance {
    static MTExpStorage *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSDictionary *)updateExpItem:(MTExpListCellItem *)item
                       withDict:(NSDictionary *)dict {
    NSMutableDictionary *result = dict.mutableCopy;
    NSMutableDictionary *groupDict = [(dict[item.groupTitle] ?: @{}) mutableCopy];
    groupDict[item.title] = item.subTitle;
    result[item.groupTitle] = groupDict;
    return result;
}

- (void)saveExpItem:(MTExpListCellItem *)item {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        self.wujiCache = [self updateExpItem:item withDict:self.wujiCache];
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        self.disguisedCache = [self updateExpItem:item withDict:self.disguisedCache];
        dispatch_semaphore_signal(self.lock);
        [self writeToFile];
    });
}

- (NSDictionary *)removeExpItem:(MTExpListCellItem *)item
                       withDict:(NSDictionary *)dict {
    NSMutableDictionary *result = dict.mutableCopy;
    NSMutableDictionary *groupDict = [(dict[item.groupTitle] ?: @{}) mutableCopy];
    groupDict[item.title] = nil;
    result[item.groupTitle] = groupDict;
    return result;
}

- (void)removeExpItem:(MTExpListCellItem *)item {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        self.wujiCache = [self removeExpItem:item withDict:self.wujiCache];
        self.disguisedCache = [self removeExpItem:item withDict:self.disguisedCache];
        [self writeToFile];
    });
}

- (void)writeToFile {
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.wujiCache options:NSJSONWritingFragmentsAllowed error:&error];
    [data writeToFile:self.wujiPath atomically:YES];
    if (error) {
        NSLog(@"writeToFile %@", error);
    }
}


+ (void)modifyExpValueAtIndexPath:(NSIndexPath *)indexPath
                           WithVC:(UIViewController<MTExpVCPresenter> *)vc {
    MTExpListCellItem *item = [vc.dataSource modelAtIndexPath:indexPath];
    NSString *message = [NSString stringWithFormat:@"原始值 %@", item.subTitle];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:item.title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"自定义实验值";
        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }];
    __weak typeof (UIViewController <MTExpVCPresenter> *) weakVC = vc;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakVC.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认"
                                                      style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction *action) {
        NSString *newValue = alert.textFields.firstObject.text;
        if (newValue.length > 0) {
            [item addSubTitle:newValue];
            // 如果是本地添加的不修改状态
            [item addExpState:[self expStateWithItem:item]];
            [weakVC.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [MTExpStorage.sharedInstance saveExpItem:item];
        }
        [weakVC.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    [alert addAction:cancel];
    [alert addAction:confirm];
    [weakVC showDetailViewController:alert sender:nil];
}

+ (NSInteger)expStateWithItem:(MTExpListCellItem *)item {
    NSDictionary *dict = MTExpStorage.sharedInstance.configCache[item.groupTitle];
    return [[dict[item.title] description] isEqualToString:item.subTitle] ? 0 : 2;
}

#pragma mark <MTExpFileMonitorDelegate>
- (void)fileMonitor:(MTExpFileMonitor *)fileMonitor
       didSeeChange:(MTExpFileMonitorChangeType)changeType {
    dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
    self.disguisedCache = nil;
    dispatch_semaphore_signal(self.lock);
}

- (NSDictionary *)wujiCache {
    if (!_wujiCache) {
        NSData *data = [NSData dataWithContentsOfFile:self.wujiPath];
        if (data) {
            NSError *error;
            _wujiCache = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingFragmentsAllowed error:&error];
            if (error) {
                NSLog(@"wujiDict %@", error);
            }
        }
        if (!_wujiCache) {
            _wujiCache = @{};
        }
    }
    return _wujiCache;
}

- (NSDictionary *)configCache {
    if (!_configCache) {
        _configCache = @{};
    }
    return _configCache;
}

- (NSDictionary *)disguisedCache {
    if (!_disguisedCache) {
        dispatch_semaphore_wait(self.lock, DISPATCH_TIME_FOREVER);
        NSMutableDictionary *result = NSMutableDictionary.dictionary;
        for (NSString *key in self.configCache) {
            id wujiValue = self.wujiCache[key];
            id configValue = self.configCache[key];
            if ([wujiValue isKindOfClass:NSArray.class] && ![(NSArray *)wujiValue isEqualToArray:configValue]) {
                result[key] = wujiValue;
                continue;
            }
            if ([wujiValue isKindOfClass:NSDictionary.class] && ![(NSDictionary *)wujiValue isEqualToDictionary:configValue]) {
                NSMutableDictionary *dict = [configValue mutableCopy];
                for (NSString *key in wujiValue) {
                    dict[key] = wujiValue[key];
                }
                result[key] = dict.copy;
                continue;
            }
            result[key] = configValue;
        }
        _disguisedCache = result;
        dispatch_semaphore_signal(self.lock);
    }
    return _disguisedCache;
}

- (NSString *)wujiPath {
    if (!_wujiPath) {
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        _wujiPath = [cachePath stringByAppendingPathComponent:@"/wuji.json"];
    }
    return _wujiPath;
}

- (NSString *)configCachePath {
    if (!_configCachePath) {
        _configCachePath = @"";
    }
    return _configCachePath;
}

- (MTExpFileMonitor *)monitor {
    if (!_monitor) {
        NSString *cachePath = self.configCachePath;
        _monitor = [[MTExpFileMonitor alloc] initWithURL:[NSURL fileURLWithPath:cachePath]];
        _monitor.delegate = self;
    }
    return _monitor;
}

- (dispatch_semaphore_t)lock {
    if (!_lock) {
        _lock = dispatch_semaphore_create(1);
    }
    return _lock;
}

@end
