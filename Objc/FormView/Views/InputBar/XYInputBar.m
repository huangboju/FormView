//
//  XYInputBar.m
//  FormView
//
//  Created by 黄伯驹 on 30/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYInputBar.h"

static const CGFloat margin = 10;
static const CGFloat padding = 15;

@interface XYInputBar()

@property (nonatomic, strong) UIVisualEffectView *visualView;

@property (nonatomic, strong) UIView *separatorLine;

@property (nonatomic, copy) NSString *oldStr;

@property (nonatomic, assign) NSUInteger oldLines;

@property (nonatomic, strong) NSLayoutConstraint *leftConstraint;

@property (nonatomic, strong) NSLayoutConstraint *rightConstraint;

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
        [self p_constraintWithItem:self.visualView
                         attribute:NSLayoutAttributeTop];
        [self p_constraintWithItem:self.visualView
                         attribute:NSLayoutAttributeHeight];
        [self p_constraintWithItem:self.visualView
                         attribute:NSLayoutAttributeLeading];
        [self p_constraintWithItem:self.visualView
                         attribute:NSLayoutAttributeWidth];

        [self addSubview:self.separatorLine];
        [self p_constraintWithItem:self.separatorLine
                         attribute:NSLayoutAttributeTop];
        [self p_constraintWithItem:self.separatorLine
                         attribute:NSLayoutAttributeLeading];
        [self p_constraintWithItem:self.separatorLine
                         attribute:NSLayoutAttributeCenterX];
        NSLayoutConstraint *heightConstraint = [NSLayoutConstraint
                                                constraintWithItem:self.separatorLine
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:0
                                                          constant:0.5];
        [self addConstraint:heightConstraint];
        

        [self addSubview:self.textView];
        [self p_constraintWithItem:self.textView
                         attribute:NSLayoutAttributeTop constant:6];
        [self p_constraintWithItem:self.textView
                         attribute:NSLayoutAttributeCenterY];
        
        self.leftConstraint = [self p_constraintWithItem:self.textView
                         attribute:NSLayoutAttributeLeading
                          constant:padding];
        self.rightConstraint = [self p_constraintWithItem:self.textView
                         attribute:NSLayoutAttributeTrailing
                          constant:-padding];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (NSLayoutConstraint *)p_constraintWithItem:(UIView *)view1 attribute:(NSLayoutAttribute)attr1 {
    return [self p_constraintWithItem:view1 attribute:attr1 constant:0];
}

- (NSLayoutConstraint *)p_constraintWithItem:(UIView *)view1 attribute:(NSLayoutAttribute)attr1 constant:(CGFloat)c {
    return [self p_constraintWithItem:view1 attribute:attr1 toItem:self constant:c];
}

- (NSLayoutConstraint *)p_constraintWithItem:(UIView *)view1
                   attribute:(NSLayoutAttribute)attr1
                      toItem:(UIView *)view2
                    constant:(CGFloat)c {
    return [self p_constraintWithItem:view1
                     attribute:attr1
                        toItem:view2
                     attribute:attr1
                      constant: c];
}

- (NSLayoutConstraint *)p_constraintWithItem:(UIView *)view1
                   attribute:(NSLayoutAttribute)attr1
                      toItem:(UIView *)view2
                   attribute:(NSLayoutAttribute)attr2
                    constant:(CGFloat)c {
    view1.translatesAutoresizingMaskIntoConstraints = NO;
    view2.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *constraint = [NSLayoutConstraint
                                      constraintWithItem:view1
                                      attribute:attr1
                                      relatedBy:NSLayoutRelationEqual
                                      toItem:view2
                                      attribute:attr2
                                      multiplier:1
                                      constant:c];
    [self addConstraint:constraint];
    return constraint;
}

- (CGSize)intrinsicContentSize {
    CGFloat height = [self textHeight];
    return CGSizeMake(self.bounds.size.width, height);
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
            [self.textView layoutIfNeeded];
            CGPoint bottomOffset = CGPointMake(0, self.textView.contentSize.height - self.textView.bounds.size.height);
            self.textView.contentOffset = bottomOffset;
        });
    } else {
        if (numLines == self.maxShowLines - 1 || self.textView.text.length < 1) {
            [self.textView invalidateIntrinsicContentSize];
        }
        self.textView.scrollEnabled = NO;
    }
}

- (CGFloat)textHeight {
    static NSCache <NSNumber *, NSNumber *>*cache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    NSInteger lines = [self numberOflines];
    CGFloat flattedValue = [cache objectForKey:@(lines)].floatValue;
    if (flattedValue) {
        return flattedValue;
    }
    CGFloat height = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, self.frame.size.height)].height;
    CGFloat scale = [UIScreen mainScreen].scale;
    flattedValue = ceil(height * scale) / scale - 6;
    [cache setObject:@(flattedValue) forKey:@(lines)];
    return flattedValue;
}

// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/TextLayout/Tasks/CountLines.html
- (NSUInteger)numberOflines {
    
    NSLayoutManager *layoutManager = [self.textView layoutManager];
    NSUInteger numberOfGlyphs = [layoutManager numberOfGlyphs];
    NSUInteger numberOfLines = 0, index = 0;
    NSRange lineRange;
    while (index < numberOfGlyphs) {
        (void) [layoutManager lineFragmentRectForGlyphAtIndex:index
                                               effectiveRange:&lineRange];
        index = NSMaxRange(lineRange);
        numberOfLines += 1;
    }
    return numberOfLines;
}

- (UIView *)separatorLine {
    if (!_separatorLine) {
        _separatorLine = [UIView new];
        _separatorLine.backgroundColor = [UIColor colorWithWhite:0.75f alpha:1];
        _separatorLine.translatesAutoresizingMaskIntoConstraints = NO;
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

- (void)setLeftButton:(UIButton *)leftButton {
    _leftButton = leftButton;
    [self setPriorityWithView:leftButton];
    [self addSubview:leftButton];
    [self removeConstraint:self.leftConstraint];
    [self p_constraintWithItem:leftButton
                     attribute:NSLayoutAttributeLeading
                      constant:margin];
    [self p_constraintWithItem:leftButton
                     attribute:NSLayoutAttributeBottom
                      constant:-margin];
    [self p_constraintWithItem:self.textView
                     attribute:NSLayoutAttributeLeading
                        toItem:leftButton
                     attribute:NSLayoutAttributeTrailing
                      constant:margin];
}

- (void)setRightButtons:(NSArray<UIButton *> *)rightButtons {
    _rightButtons = rightButtons;
    __block UIView *tmpView;
    [self removeConstraint:self.rightConstraint];
    [rightButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self setPriorityWithView:obj];
        [self addSubview:obj];
        if (idx == 0) {
            [self p_constraintWithItem:obj
                             attribute:NSLayoutAttributeLeading
                                toItem:self.textView
                             attribute:NSLayoutAttributeTrailing
                              constant:margin];
        } else {
            [self p_constraintWithItem:tmpView
                             attribute:NSLayoutAttributeTrailing
                                toItem:obj
                             attribute:NSLayoutAttributeLeading
                              constant:-margin];
        }
        [self p_constraintWithItem:obj
                         attribute:NSLayoutAttributeBottom
                          constant:-margin];
        if (idx == rightButtons.count - 1) {
            [self p_constraintWithItem:obj      attribute:NSLayoutAttributeTrailing
                              constant:-margin];
        }
        tmpView = obj;
    }];
}

- (void)setRightButton:(UIButton *)rightButton {
    _rightButton = rightButton;
    [self setPriorityWithView:rightButton];
    [self addSubview:self.rightButton];
    [self removeConstraint:self.rightConstraint];
    [self p_constraintWithItem:self.rightButton
                     attribute:NSLayoutAttributeTrailing
                      constant:-margin];
    [self p_constraintWithItem:self.rightButton
                     attribute:NSLayoutAttributeLeading
                        toItem:self.textView
                     attribute:NSLayoutAttributeTrailing
                      constant:margin];
    [self p_constraintWithItem:self.rightButton
                     attribute:NSLayoutAttributeBottom
                      constant:-margin];
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

- (void)setPriorityWithView:(UIView *)view {
    [view setContentCompressionResistancePriority:999 forAxis:UILayoutConstraintAxisHorizontal];
    [view setContentHuggingPriority:999 forAxis:UILayoutConstraintAxisHorizontal];
}

@end
