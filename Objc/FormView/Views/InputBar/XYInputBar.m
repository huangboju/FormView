//
//  XYInputBar.m
//  FormView
//
//  Created by 黄伯驹 on 30/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYInputBar.h"

#import <Masonry.h>

@interface XYInputBar()

@property (nonatomic, strong) UIVisualEffectView *visualView;

@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, copy) NSString *oldStr;

@property (nonatomic, assign) NSUInteger oldLines;

@end

@implementation XYInputBar

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)bar {
    XYInputBar *bar = [[self alloc] init];
    return bar;
}

- (instancetype)initWithFrame:(CGRect)frame {
    // 47 参考微信
    if (self = [super initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 47)]) {

        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor whiteColor];
        
        self.maxShowLines = 5;

        [self addSubview:self.visualView];
        [self.visualView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];

        [self addSubview:self.separatorLine];
        [self.separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.centerX.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];

        CGFloat margin = 10;

        [self addSubview:self.changeKeyboardBtn];
        [self.changeKeyboardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(margin);
            make.bottom.mas_equalTo(-margin);
        }];

        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.changeKeyboardBtn.mas_trailing).offset(margin);
            make.top.mas_equalTo(6);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];

        [self addSubview:self.secondButton];
        [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.textView.mas_trailing).offset(margin);
            make.size.centerY.mas_equalTo(self.changeKeyboardBtn);
        }];

        [self addSubview:self.thirdButton];
        [self.thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.secondButton.mas_trailing).offset(margin);
            make.size.centerY.mas_equalTo(self.changeKeyboardBtn);
            make.trailing.mas_equalTo(-margin);
        }];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGFloat height = [self textHeight];
    return CGSizeMake(self.bounds.size.width, floor(height));
}

- (void)textViewTextDidChange:(NSNotification *)notification {

    // 这里会走两次
    if ([self.oldStr isEqualToString:self.textView.text]) {
        return;
    }
    self.oldStr = self.textView.text;

    NSUInteger numLines = [self numberOflines];

    if (self.oldLines == numLines) {
        return;
    }
    self.oldLines = numLines;

    UIEdgeInsets inset = self.textView.textContainerInset;
    // 超过一行上面间距变化，参考微信
    if (numLines > 1) {
        self.textView.textContainerInset = UIEdgeInsetsMake(3, inset.left, 3, inset.right);
    } else {
        self.textView.textContainerInset = UIEdgeInsetsMake(8, inset.left, 8, inset.right);
    }

    if (numLines > self.maxShowLines - 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.textView.scrollEnabled = YES;
            if (numLines > self.maxShowLines) {
                [self.textView layoutIfNeeded];
                CGPoint bottomOffset = CGPointMake(0, self.textView.contentSize.height - self.textView.bounds.size.height);
                self.textView.contentOffset = bottomOffset;
            }
        });
    } else {
        self.textView.scrollEnabled = NO;
    }
    [self invalidateIntrinsicContentSize];
}

- (CGFloat)textHeight {
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rect = [self.textView.text boundingRectWithSize:CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX) options:options attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil];
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat flattedValue = ceil(rect.size.height * scale) / scale;
    return flattedValue - 2 * scale;
}

// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/TextLayout/Tasks/CountLines.html
- (NSUInteger )numberOflines {
    NSLayoutManager *layoutManager = [self.textView layoutManager];
    NSUInteger numberOfLines, index;
    NSUInteger numberOfGlyphs = [layoutManager numberOfGlyphs];
    NSRange lineRange;
    for (numberOfLines = 0, index = 0; index < numberOfGlyphs; numberOfLines++){
        (void) [layoutManager lineFragmentRectForGlyphAtIndex:index
                                               effectiveRange:&lineRange];
        index = NSMaxRange(lineRange);
    }
    return numberOfLines;
}

- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [UIView new];
        _separatorLine.backgroundColor = [UIColor colorWithWhite:0.75f alpha:1];
    }
    return _separatorLine;
}

- (UIVisualEffectView *)visualView {
    if (!_visualView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        _visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    }
    return _visualView;
}

- (UIButton *)changeKeyboardBtn {
    if (!_changeKeyboardBtn) {
        _changeKeyboardBtn = [self generateButtonWithImageName:@"icon_emotion"];
    }
    return _changeKeyboardBtn;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.layer.borderWidth = 0.5;
        _textView.layer.cornerRadius = 5;
        [_textView setContentCompressionResistancePriority:500 forAxis:UILayoutConstraintAxisHorizontal];
        _textView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
        _textView.scrollEnabled = NO;
        _textView.layoutManager.allowsNonContiguousLayout = NO;
    }
    return _textView;
}

- (UIButton *)secondButton {
    if (!_secondButton) {
        _secondButton = [self generateButtonWithImageName:@"icon_emotion"];
    }
    return _secondButton;
}

- (UIButton *)thirdButton {
    if (!_thirdButton) {
        _thirdButton = [self generateButtonWithImageName:@"icon_emotion"];
    }
    return _thirdButton;
}

- (UIButton *)generateButtonWithImageName:(NSString *)imageName {
    UIButton *button = [UIButton new];
    [button setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
    [button setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return button;
}


@end
