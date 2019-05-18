//
//  XYPHSearchFilterNotesCellNew.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/3/7.
//

#import <Masonry/Masonry.h>
#import "UIView+Extension.h"
#import "Theme.h"

#import "XYPHSearchFilterNotesCell.h"

#import "XYPHSearchFilterShowMoreControl.h"
#import "XYPHSearchFilterButtonsView.h"
#import "XYPHSFViewControllerPresenter.h"

@interface XYPHSearchFilterNotesCell() <XYPHSearchFilterButtonsViewDelegate>

@property (nonatomic, strong) XYPHSearchFilterButtonsView *containerView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) XYPHSearchFilterShowMoreControl *showMoreControl;

@property (nonatomic, strong) XYPHSFNotesCellModel *viewData;

@end

@implementation XYPHSearchFilterNotesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.top.mas_equalTo(0);
        }];
        
        [self.contentView addSubview:self.showMoreControl];
        [self.showMoreControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.titleLabel);
        }];
        
        [self.contentView addSubview:self.containerView];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.leading.mas_equalTo(15);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(25);
            make.bottom.mas_equalTo(-20);
            make.height.mas_equalTo(82).priority(999);
        }];
    }
    return self;
}

- (void)updateViewData:(XYPHSFNotesCellModel *)viewData {
    _viewData = viewData;
    
    self.titleLabel.text = viewData.groupName;
    
    // 小于六个没有显示更多
    self.showMoreControl.hidden = viewData.noShowMore;
    self.showMoreControl.selected = viewData.expanding;

    [self expandingWithFlag:viewData.expanding];
    
    [self.containerView updateViewData:viewData.items];
}



#pragma mark <XYPHSearchFilterButtonsViewDelegate>

- (void)searchFilterButtonsViewItemClickedWithSender:(XYPHSFButton *)sender {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFNotesFilterCellDelegate)]) {
        // 是否超过最多可以选择的15个
        if (self.selectedFilters.isOutOfRange) {
            return;
        }
        if (self.viewData.isMulti) {
            [self multiSelect:sender];
        } else {
            [self singleSelect:sender];
        }
    }
}

- (void)singleSelect:(XYPHSFButton *)sender {
    if (sender.isSelected) {
        // 取消选中
        sender.selected = NO;
        [self deselectedWithCellModel:sender.item];
    } else {
        [self.selectedFilters removeFiltersWithGroupId:self.viewData.groupId];
        [self.containerView deselectedAll];
        sender.selected = YES;
        [self selectedWithCellModel:sender.item];
    }
}

- (void)multiSelect:(XYPHSFButton *)sender {
    if (sender.isSelected) {
        // 取消选中
        sender.selected = NO;
        [self deselectedWithCellModel:sender.item];
    } else {
        sender.selected = YES;
        [self selectedWithCellModel:sender.item];
        
    }
}

- (void)selectedWithCellModel:(XYPHSearchFilterTagCellModel *)cellModel {
    [self selectionBIWithCellModel:cellModel];
    NSString *groupId = self.viewData.groupId;
    NSString *tagId = cellModel.tagId;
    [self.selectedFilters addFilterToGroup:groupId tagId:tagId];
    if (self.viewData.invisible) {
        [self.delegate searchFilterNotesCellDidSelectItem:self];
    } else {
        // 外露筛选
        [self.delegate searchFilterNotesCellDidSelectItem:self];
    }
}

- (void)deselectedWithCellModel:(XYPHSearchFilterTagCellModel *)cellModel {
    [self deselectionBIWithCellModel:cellModel];
    NSString *groupId = self.viewData.groupId;
    NSString *tagId = cellModel.tagId;
    [self.selectedFilters removeFilterFromGroup:groupId tagId:tagId];
    if (self.viewData.invisible) {
        [self.delegate searchFilterNotesCellDidSelectItem:self];
    } else {
        // 外露筛选
        [self.delegate searchFilterNotesCellDidSelectItem:self];
    }
}

- (void)selectionBIWithCellModel:(XYPHSearchFilterTagCellModel *)cellModel {
    
}

- (void)deselectionBIWithCellModel:(XYPHSearchFilterTagCellModel *)cellModel {
    
}

#pragma mark Action

- (void)moreButtonClicked:(XYPHSearchFilterShowMoreControl *)sender {
    sender.selected = !sender.isSelected;
    
    [self expandingWithFlag:sender.isSelected];

    self.viewData.expanding = sender.isSelected;
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFNotesFilterCellDelegate)]) {
        [(id <XYPHSFNotesFilterCellDelegate>)vc searchFilterNotesCellMoreButtonClicked:self];
    }
}

- (void)expandingWithFlag:(BOOL)flag {
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(flag ? self.viewData.maxHeight : self.viewData.displayHeight).priority(999);
    }];
}


- (id <XYPHSFNotesFilterCellDelegate>)delegate {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFNotesFilterCellDelegate)]) {
        return (id<XYPHSFNotesFilterCellDelegate>)vc;
    }
    return nil;
}

- (XYSFSelectedFilters *)selectedFilters {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFViewControllerPresenter)]) {
        return [(id <XYPHSFViewControllerPresenter>)vc selectedFilters];
    }
    return nil;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = Theme.fontSmallBold;
        _titleLabel.textColor = Theme.colorGrayLevel1;
    }
    return _titleLabel;
}

- (XYPHSearchFilterShowMoreControl *)showMoreControl {
    if (!_showMoreControl) {
        _showMoreControl = [XYPHSearchFilterShowMoreControl new];
        [_showMoreControl addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _showMoreControl;
}

- (XYPHSearchFilterButtonsView *)containerView {
    if (!_containerView) {
        _containerView = XYPHSearchFilterButtonsView.new;
        _containerView.delegate = self;
    }
    return _containerView;
}

@end
