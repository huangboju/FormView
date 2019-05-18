//
//  MessageCenterController.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "MessageCenterController.h"

#import "MessageCenterCell.h"

@interface MessageCenterController ()<UITableViewDelegate>

@end

@implementation MessageCenterController

- (void)initSubviews {
    NSArray *imageNames = @[
                            @[
                                @"message_likeAndCollect",
                                @"message_commentAndAt",
                                @"message_follow",
                                @"message_notification"
                                ],
                            @[
                                @"message_pm"
                                ]
                            ];
    
    NSMutableArray *sections = [NSMutableArray array];
    
    for (NSArray *arr in imageNames) {
        NSMutableArray *rows = [NSMutableArray array];
        for (NSString *imageName in arr) {
            MessageCenterCellItem *item = [[MessageCenterCellItem alloc] init];
            item.imageName = imageName;
            item.desc = imageName;
            item.controllerClass = [MessageCenterController class];

            [rows addObject:[XYRow rowWithClass:MessageCenterCell.class model:item]];
        }
        [sections addObject:rows];
    }

    self.form = sections;
    self.tableView.rowHeight = 60;
    self.tableView.delegate = self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCenterCellItem *item = [self rowAtIndexPath:indexPath].model;
    UIViewController *vc = [[item.controllerClass alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
