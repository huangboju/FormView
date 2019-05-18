//
//  XYPHSearchFilterGroupButtonView.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2018/8/16.
//

#import <Masonry/Masonry.h>

#import "XYPHSearchFilterGroupButtonView.h"

#import "Theme.h"
#import "UIView+Extension.h"
#import "View+SafeArea.h"

@interface XYPHSearchFilterGroupButtonView()

@property (nonatomic, strong) UIButton *clearButton;

@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation XYPHSearchFilterGroupButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.clearButton];
        
        [self addSubview:self.doneButton];
        
        self.totalCount = 0;
        
        [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.top.bottom.mas_equalTo(0);
            make.width.mas_equalTo(120 * UIScreen.mainScreen.bounds.size.width / 375.f);
        }];
        
        [self.doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.top.bottom.mas_equalTo(0);
            make.leading.mas_equalTo(self.clearButton.mas_trailing);
        }];
        
        self.suffix = @"篇笔记";
    }
    return self;
}

- (void)attachInView:(UIView *)view {
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(view.mas_safeBottom);
        make.height.mas_equalTo(44);
    }];
}

- (void)setTotalCount:(NSInteger)totalCount {
    NSMutableAttributedString *doneTitle = [NSMutableAttributedString new];
    NSAttributedString *doneString = [[NSAttributedString alloc] initWithString:@"完成" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:Theme.fontMediumBold}];
    NSAttributedString *countString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"(%ld%@)", totalCount, self.suffix] attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:Theme.fontSmall}];
    [doneTitle appendAttributedString:doneString];
    [doneTitle appendAttributedString:countString];
    [self.doneButton setAttributedTitle:doneTitle forState:UIControlStateNormal];
}

- (void)resetButtonTouchUpInside:(UIButton *)sender {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSearchFilterGroupButtonViewDelegate)]) {
        [(id <XYPHSearchFilterGroupButtonViewDelegate>)vc searchFilterGroupButtonViewClearButtonClicked:self];
    }
}

- (void)doneButtonTouchUpInside:(UIButton *)sender {
    UIViewController *vc = self.viewController;
    if ([vc conformsToProtocol:@protocol(XYPHSearchFilterGroupButtonViewDelegate)]) {
        [(id <XYPHSearchFilterGroupButtonViewDelegate>)vc searchFilterGroupButtonViewDoneButtonClicked:self];
    }
}

- (UIButton *)clearButton {
    if (!_clearButton) {
        _clearButton = [UIButton new];
        [_clearButton setTitle:@"清空" forState:UIControlStateNormal];
        [_clearButton setTitleColor:Theme.colorGrayLevel1 forState:UIControlStateNormal];
        [_clearButton setTitleColor:Theme.colorGrayLevel3 forState:UIControlStateHighlighted];
        _clearButton.backgroundColor = [UIColor whiteColor];
        _clearButton.titleLabel.font = Theme.fontLarge;
        [_clearButton addTarget:self action:@selector(resetButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        _clearButton.layer.shadowColor = [UIColor blackColor].CGColor;
        _clearButton.layer.shadowOffset = CGSizeMake(0, -2);
        _clearButton.layer.shadowOpacity = 0.04;
        _clearButton.layer.shadowRadius = 5;
    }
    return _clearButton;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIButton new];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneButton setTitleColor:Theme.colorGrayLevel3 forState:UIControlStateHighlighted];
        _doneButton.backgroundColor = Theme.colorRed;
        _doneButton.titleLabel.font = Theme.fontLarge;
        [_doneButton addTarget:self action:@selector(doneButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

@end
