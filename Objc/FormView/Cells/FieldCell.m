//
//  FieldCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "FieldCell.h"


@interface FieldCell()

@property(nonatomic, strong, readwrite) UITextField *textField;

@end



@implementation FieldCell

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _textField;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.textField];
        [self.textField.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:15].active = YES;
        [self.textField.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = YES;
        [self.textField.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [self.textField.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    }
    return self;
}

- (void)setInputText:(NSString *)inputText {
    self.textField.text = inputText;
}

- (NSString *)inputText {
    return self.textField.text;
}

@end
