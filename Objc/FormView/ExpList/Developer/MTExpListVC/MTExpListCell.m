//
//  MTExpListCell.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/3/18.
//  Copyright © 2021 xiAo-Ju. All rights reserved.
//


#import "MTExpListCell.h"

// MTExpListCellItem
@interface MTExpListCellItem ()

/// 修改过的实验
@property (nonatomic, assign) NSInteger expState;

@property (nonatomic, copy) NSString *groupTitle;

@end

// MTExpListCellItem
@implementation MTExpListCellItem

- (instancetype)init {
    if (self = [super init]) {
        [self addCellStyle:UITableViewCellStyleValue1];
        [self addsubTitleColor:[UIColor colorWithWhite:0.6 alpha:1]];
    }
    return self;
}

- (void)addExpState:(NSInteger)expState {
    self.expState = expState;
}

- (void)addGroupTitle:(NSString *)groupTitle {
    self.groupTitle = groupTitle;
}

- (UIColor *)cellBackgroundColor {
    if (self.expState == 1) {
        return [UIColor colorWithRed:1 green:59.f/255.f blue:48.f/255.f alpha:0.5];
    } else if (self.expState == 2) {
        return [UIColor colorWithRed:1 green:149.f/255.f blue:0 alpha:0.5];
    }
    return UIColor.whiteColor;
}

@end




@interface MTExpListCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIView *spacingView;

@property (nonatomic, strong) UIStackView *stackView;

@property (nonatomic, strong) NSLayoutConstraint *spacingViewHeight;

@property (nonatomic, strong) NSLayoutConstraint *spacingViewWidth;

@end

@implementation MTExpListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.stackView];
        [NSLayoutConstraint activateConstraints:@[
            [self.stackView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
            [self.stackView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor],
            [self.stackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8],
            [self.stackView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor],
            [self.stackView.heightAnchor constraintGreaterThanOrEqualToConstant:44]
        ]];
        
        self.spacingViewWidth = [self.spacingView.widthAnchor constraintGreaterThanOrEqualToConstant:8];
        self.spacingViewHeight = [self.spacingView.heightAnchor constraintGreaterThanOrEqualToConstant:8];
    }
    return self;
}

- (void)updateViewData:(MTExpListCellItem *)viewData {
    
    self.contentView.backgroundColor = viewData.cellBackgroundColor;
    
    self.titleLabel.text = viewData.title;
    self.titleLabel.font = viewData.titleFont;
    self.titleLabel.textColor = viewData.titleColor;

    self.subTitleLabel.text = viewData.subTitle;
    self.subTitleLabel.textColor = viewData.subTitleColor;

    if (viewData.cellStyle == UITableViewCellStyleSubtitle) {
        self.subTitleLabel.numberOfLines = 0;
        self.subTitleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.spacingViewWidth.active = NO;
        self.spacingViewHeight.active = YES;
        
        self.stackView.axis = UILayoutConstraintAxisVertical;
    } else {
        self.subTitleLabel.numberOfLines = 1;
        self.subTitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.spacingViewHeight.active = NO;
        self.spacingViewWidth.active = YES;

        self.stackView.axis = UILayoutConstraintAxisHorizontal;
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        [_titleLabel setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisVertical];
        [_titleLabel setContentCompressionResistancePriority:749 forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = UILabel.new;
        [_spacingView setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisVertical];
        [_spacingView setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisHorizontal];
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

- (UIView *)spacingView {
    if (!_spacingView) {
        _spacingView = UIView.new;
        _spacingView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _spacingView;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] initWithArrangedSubviews:@[
            self.titleLabel,
            self.spacingView,
            self.subTitleLabel
        ]];
        _stackView.translatesAutoresizingMaskIntoConstraints = NO;
        _stackView.distribution = UIStackViewDistributionFill;
    }
    return _stackView;
}

@end
