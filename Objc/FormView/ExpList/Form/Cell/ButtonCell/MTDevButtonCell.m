//
//  MTDevButtonCell.m
//  MTDeveloperModule
//
//  Created by xiAo-Ju on 2021/2/24.
//

#import "MTDevButtonCell.h"

@implementation MTDevButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:18];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)updateViewData:(MTDevButtonCellItem *)viewData {
    self.textLabel.text = viewData.title;
    self.textLabel.textColor = viewData.titleColor;
}


@end
