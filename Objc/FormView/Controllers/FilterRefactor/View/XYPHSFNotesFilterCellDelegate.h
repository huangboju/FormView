//
//  XYPHSFNotesFilterCellDelegate.h
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/7.
//

@class XYPHSearchFilterNotesCell;

NS_ASSUME_NONNULL_BEGIN

@protocol XYPHSFNotesFilterCellDelegate <NSObject>

- (void)searchFilterNotesCellMoreButtonClicked:(XYPHSearchFilterNotesCell *)cell;

- (void)searchFilterNotesCellDidSelectItem:(XYPHSearchFilterNotesCell *)cell;

@end

NS_ASSUME_NONNULL_END
