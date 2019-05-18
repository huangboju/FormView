//
//  XYPHSFPriceFieldCell.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/12.
//

#import <Masonry/Masonry.h>
#import "Theme.h"
#import "UIView+Extension.h"
#import "UIColor+Hex.h"

#import "XYPHSFPriceFieldCell.h"

#import "XYPHSFRecommendPriceView.h"

#import "XYPHSearchGoodsRecommendPriceRange.h"

#import "XYPHSFViewControllerPresenter.h"

@interface XYPHSFPriceFieldCell() <XYPHSFRecommendPriceViewDelegate>

@property (nonatomic, strong) UIView *dummyView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UITextField *minPriceField;

@property (nonatomic, strong) UITextField *maxPriceField;

@property (nonatomic, strong) UIView *midLine;

@property (nonatomic, assign) BOOL isNotInput;

@property (nonatomic, strong) XYPHSFRecommendPriceView *recommendPriceView;

@property (nonatomic, strong) XYPHSFPriceFieldCellModel *viewData;

@end

@implementation XYPHSFPriceFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.dummyView];
        [self.dummyView addSubview:self.titleLabel];
        [self.dummyView addSubview:self.minPriceField];
        [self.dummyView addSubview:self.maxPriceField];
        [self.dummyView addSubview:self.midLine];
        [self.dummyView addSubview:self.recommendPriceView];
        
        [self.dummyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(15);
            make.center.mas_equalTo(0).priority(999);
            make.height.top.mas_equalTo(0);
            make.bottom.mas_equalTo(-20);
        }];
        
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.top.mas_equalTo(0);
        }];
        
        [self.minPriceField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(25);
            make.leading.mas_equalTo(0);
            make.height.mas_equalTo(36);
        }];
        
        [self.midLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1.5);
            make.width.mas_equalTo(11);
            make.leading.mas_equalTo(self.minPriceField.mas_trailing).mas_equalTo(7);
            make.trailing.mas_equalTo(self.maxPriceField.mas_leading).mas_equalTo(-7);
            make.centerY.mas_equalTo(self.minPriceField);
        }];
        
        [self.maxPriceField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(0);
            make.centerY.mas_equalTo(self.minPriceField);
            make.width.height.mas_equalTo(self.minPriceField);
        }];
        
        [self.recommendPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(44);
            make.leading.mas_equalTo(self.minPriceField);
            make.trailing.mas_equalTo(self.maxPriceField);
            make.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

#pragma mark <XYPHSFRecommendPriceViewDelegate>
- (void)secommendPriceCellItemClicked:(XYPHSFRecommendPriceView *)sender {
    XYPHSearchGoodsRecommendPriceRange *selectedRange = sender.selectedRange;
    self.minPrice = selectedRange.minPrice;
    self.maxPrice = selectedRange.maxPrice;
    [self completeInput];
}

- (void)updateViewData:(XYPHSFPriceFieldCellModel *)viewData {
    _viewData = viewData;
    self.minPrice = viewData.minPrice;
    self.maxPrice = viewData.maxPrice;

    self.recommendPriceView.hidden = YES;
    if (viewData.needShowRecommendPrice) {
        self.recommendPriceView.hidden = NO;
        [self.recommendPriceView updateViewData:viewData.model];
        [self updateRecommendPriceView];
    }
    
    [self.dummyView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewData.cellSize.height + 40);
    }];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.viewData = nil;
    self.minPriceField.text = nil;
    self.maxPriceField.text = nil;
}

- (void)completeInput {
    [self checkMaxIfNeededHandle];
    self.viewData.minPrice = self.minPrice;
    self.viewData.maxPrice = self.maxPrice;
    [self addPriceIfNeeded];
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFPriceFieldCellDelegate)]) {
        [(id <XYPHSFPriceFieldCellDelegate>)vc searchFilterPriceFieldCellCompleteInput:self];
    }
}

- (void)doneBarButtonClicked:(UIBarButtonItem *)sender {
    [self.contentView endEditing:YES];
}

- (NSString *)minPrice {
    return self.minPriceField.text;
}

- (NSString *)maxPrice {
    return self.maxPriceField.text;
}

- (void)setMinPrice:(NSString *)minPrice {
    self.minPriceField.text = minPrice;
}

- (void)setMaxPrice:(NSString *)maxPrice {
    self.maxPriceField.text = maxPrice;
}

- (void)addPriceIfNeeded {
    if (self.isNotInput) {
        [self.selectedFilters removeFiltersWithGroupId:@"price"];
    } else {
        self.selectedFilters[@"price"] = [NSOrderedSet orderedSetWithArray:@[self.minPrice, self.maxPrice]];
    }
}

- (void)checkMaxIfNeededHandle {
    NSString *minPrice = self.minPrice;
    NSString *maxPrice = self.maxPrice;
    BOOL minPriceEmpty = minPrice.length < 1;
    BOOL maxPriceEmpty = maxPrice.length < 1;
    self.isNotInput = minPriceEmpty && maxPriceEmpty;
    if (minPriceEmpty && maxPriceEmpty) { return; }
    if (minPrice.integerValue > maxPrice.integerValue && !maxPriceEmpty) {
        self.minPriceField.text = maxPrice;
        self.maxPriceField.text = minPrice;
    }
}

- (void)maxPriceFieldEditingChanged:(UITextField *)sender {
    self.viewData.maxPrice = sender.text;
    [self updateRecommendPriceView];
}

- (void)minPriceFieldEditingChanged:(UITextField *)sender {
    self.viewData.minPrice = sender.text;
    [self updateRecommendPriceView];
}

- (void)updateRecommendPriceView {
    [self.recommendPriceView updateSelectedStatusIfNeededWithMin:self.minPrice max:self.maxPrice];
}

- (XYSFSelectedFilters *)selectedFilters {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSFViewControllerPresenter)]) {
        return [(id <XYPHSFViewControllerPresenter>)vc selectedFilters];
    }
    return nil;
}

- (UITextField *)generatePriceFieldWithPlaceholder:(NSString *)placeholder {
    UITextField *field = [UITextField new];
    field.backgroundColor = [UIColor colorWithHex:0xF5F8FA];
    field.layer.cornerRadius = 4;
    field.tintColor = Theme.colorRed;
    field.textAlignment = NSTextAlignmentCenter;
    field.keyboardType = UIKeyboardTypeNumberPad;
    field.font = Theme.fontSmall;
    field.textColor = Theme.colorGrayLevel1;
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:placeholder attributes:@{
                                                                                                   NSFontAttributeName: Theme.fontSmall,
                                                                                                   NSForegroundColorAttributeName: Theme.colorGrayLevel3
                                                                                                   }];
    field.attributedPlaceholder = attr;
    return field;
}

- (UIView *)inputAccessoryView {
    UIToolbar *accessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), 44)];
    accessoryView.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBarButtonClicked:)];
    right.tintColor = [UIColor colorWithHex:0x5B92E1];
    accessoryView.items = @[flexible, right];
    return accessoryView;
}

- (XYPHSFRecommendPriceView *)recommendPriceView {
    if (!_recommendPriceView) {
        _recommendPriceView = XYPHSFRecommendPriceView.new;
        _recommendPriceView.delegate = self;
        _recommendPriceView.hidden = YES;
    }
    return _recommendPriceView;
}

- (UIView *)midLine {
    if (!_midLine) {
        _midLine = [UIView new];
        _midLine.backgroundColor = Theme.colorGrayLevel3;
    }
    return _midLine;
}


- (UITextField *)minPriceField {
    if (!_minPriceField) {
        _minPriceField = [self generatePriceFieldWithPlaceholder:@"最低价"];
        [_minPriceField addTarget:self action:@selector(minPriceFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _minPriceField;
}

- (UITextField *)maxPriceField {
    if (!_maxPriceField) {
        _maxPriceField = [self generatePriceFieldWithPlaceholder:@"最高价"];
        [_maxPriceField addTarget:self action:@selector(maxPriceFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _maxPriceField;
}

- (UIView *)dummyView {
    if (!_dummyView) {
        _dummyView = UIView.new;
    }
    return _dummyView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"价格区间";
        _titleLabel.font = Theme.fontSmallBold;
        _titleLabel.textColor = Theme.colorGrayLevel1;
    }
    return _titleLabel;
}

@end

