//
//  LicenseCell.m
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import "LicenseCell.h"

@implementation LicenseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.textLabel.textColor = [UIColor colorWithWhite:0.8 alpha:1];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.text = @"By signing up, you agree to the Terms & Privacy Policy.";
    }
    return self;
}

@end
