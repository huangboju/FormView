//
//  XYPHSearchFilterNotesCellNew.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/7.
//

#import "XYUpdatable.h"
#import "XYPHSFNotesCellModel.h"
#import "XYPHSFNotesFilterCellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface XYPHSearchFilterNotesCell : UITableViewCell <XYUpdatable>

@property (nonatomic, strong, readonly) XYPHSFNotesCellModel *viewData;

@end

NS_ASSUME_NONNULL_END
