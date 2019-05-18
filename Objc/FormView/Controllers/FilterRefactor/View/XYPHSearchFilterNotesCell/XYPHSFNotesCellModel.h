//
//  XYPHSearchFilterNotesCellModel.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/4.
//

#import "XYPHSearchFilterTagCellModel.h"
#import "XYPHSearchFilterGroupPresenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSFNotesCellModel : NSObject

+ (instancetype)modelWithModel:(id <XYPHSearchFilterGroupPresenter>)model
               selectedFilters:(NSOrderedSet *)selectedFilters
                           row:(NSInteger)row;

@property (nonatomic, strong, readonly) NSArray <XYPHSearchFilterTagCellModel *> *items;

@property (nonatomic, assign, readonly) NSInteger row;

@property (nonatomic, copy, readonly) NSString *groupName;

@property (nonatomic, assign) BOOL expanding;

@property (nonatomic, assign, readonly) BOOL noShowMore;

@property (nonatomic, assign, readonly) CGFloat displayHeight;

@property (nonatomic, assign, readonly) CGFloat maxHeight;

@property (nonatomic, assign, readonly) BOOL isMulti;

@property (nonatomic, copy, readonly) NSString *groupId;

@property (nonatomic, assign, readonly) BOOL invisible;

@property (nonatomic, copy, readonly) NSString *action;

@end

NS_ASSUME_NONNULL_END
