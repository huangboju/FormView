//
//  XYInputBarView.m
//  FormView
//
//  Created by 黄伯驹 on 30/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYInputBarView.h"

#import "XYInputBar.h"

@interface XYInputBarView()

@property (nonatomic, strong) XYInputBar *inputBar;

@property (nonatomic, assign) BOOL flag;

@end


@implementation XYInputBarView

- (UIView *)inputAccessoryView {
    return self.inputBar;
}

- (BOOL)canBecomeFirstResponder {
    return self.flag;
}

- (BOOL)becomeFirstResponder {
    self.flag = YES;
    BOOL result = [super becomeFirstResponder];
    [self.inputBar.textView becomeFirstResponder];
    return result;
}

- (BOOL)resignFirstResponder {
    self.flag = NO;
    [self.inputBar.textView resignFirstResponder];
    BOOL result = [super resignFirstResponder];
    return result;
}

- (XYInputBar *)inputBar {
    if (!_inputBar) {
        _inputBar = [XYInputBar bar];
    }
    return _inputBar;
}

- (void)setLeftButton:(UIButton *)leftButton {
    _leftButton = leftButton;
    self.inputBar.leftButton = leftButton;
}

- (void)setRightButton:(UIButton *)rightButton {
    _rightButton = rightButton;
    self.inputBar.rightButton = rightButton;
}

@end
