//
//  XYPHPhoneZonesCell.m
//  FormView
//
//  Created by 黄伯驹 on 24/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHPhoneZonesCell.h"
#import "XYPHContryItem.h"

@implementation XYPHPhoneZonesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)updateViewWithModel:(XYPHContryItem *)model {
    self.textLabel.text = model.name;
    self.detailTextLabel.text = model.dialCcode;
}

@end
