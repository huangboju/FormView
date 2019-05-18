//
//  XYPHSearchFilterButtonsView.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/11.
//

#import "XYPHSearchFilterButtonsView.h"

#import "XYPHSearchFilterTagCellModel.h"

@interface XYPHSearchFilterButtonsView()

@property (nonatomic, strong) NSArray <XYPHSFButton *>*buttons;

@end


@implementation XYPHSearchFilterButtonsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.whiteColor;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)deselectedAll {
    for (XYPHSFButton *button in self.buttons) {
        button.selected = NO;
    }
}

- (void)buttonClicked:(XYPHSFButton *)sender {
    if ([self.delegate respondsToSelector:@selector(searchFilterButtonsViewItemClickedWithSender:)]) {
        [self.delegate searchFilterButtonsViewItemClickedWithSender:sender];
    }
}


- (void)updateViewData:(NSArray <XYPHSearchFilterTagCellModel *> *)viewData {
    [self.buttons makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:viewData.count];
    NSInteger row = 0;
    NSInteger col = 0;
    for (NSInteger i = 0; i < viewData.count; i++) {
        row = i / 3;
        if (result.count == 0 || i % 3 == 0) {
            col = 0;
        } else {
            col += 1;
        }
        XYPHSearchFilterTagCellModel *item = viewData[i];
        
        XYPHSFButton *button = [XYPHSFButton buttonWithItem:item];
        CGRect rect = button.frame;
        rect.origin.y = row * (CGRectGetHeight(rect) + 10);
        rect.origin.x = col * (CGRectGetWidth(rect) + 10);
        button.frame = rect;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [result addObject:button];
        [self addSubview:button];
    }
    self.buttons = result.copy;
}


@end
