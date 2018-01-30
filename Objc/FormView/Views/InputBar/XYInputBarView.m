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

@end


@implementation XYInputBarView

- (UIView *)inputAccessoryView {
    return self.inputBar;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    BOOL result = [super becomeFirstResponder];
    [self.inputBar.textView becomeFirstResponder];
    return result;
}

- (BOOL)resignFirstResponder {
    BOOL result = [super resignFirstResponder];
    [self.inputBar.textView resignFirstResponder];
    return result;
}

- (XYInputBar *)inputBar {
    if (!_inputBar) {
        _inputBar = [XYInputBar bar];
    }
    return _inputBar;
}

@end
