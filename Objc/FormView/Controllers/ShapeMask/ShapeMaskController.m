//
//  ShapeMaskController.m
//  FormView
//
//  Created by xiAo_Ju on 2019/1/7.
//  Copyright © 2019 黄伯驹. All rights reserved.
//

#import "ShapeMaskController.h"
#import "XYShapeImageView.h"
#import <Masonry/Masonry.h>

@interface ShapeMaskController ()

@property (nonatomic, strong) XYShapeImageView *maskLayer;

@property (nonatomic, strong) XYShapeImageView *maskView1;

@property (nonatomic, strong) XYShapeImageView *maskView2;

@end

@implementation ShapeMaskController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.maskLayer addTransparentRoundedRect:CGRectMake(2, 2, 198, 198) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(8, 8)];
    [self.view addSubview:self.maskLayer];
    
    [self.view addSubview:self.maskView1];
    [self.maskView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.mas_equalTo(self.view);
    }];
    
    [self.view addSubview:self.maskView2];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.maskLayer.maskColor = [UIColor blueColor];
}

- (XYShapeImageView *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [[XYShapeImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 202)];
        _maskLayer.maskColor = [UIColor redColor];
    }
    return _maskLayer;
}

- (XYShapeImageView *)maskView1 {
    if (!_maskView1) {
        _maskView1 = [XYShapeImageView new];
        _maskView1.maskColor = [UIColor cyanColor];
        _maskView1.cornerRadius = 8;
    }
    return _maskView1;
}

- (XYShapeImageView *)maskView2 {
    if (!_maskView2) {
        _maskView2 = [[XYShapeImageView alloc] initWithFrame:CGRectMake(10, 400, 100, 100)];
        _maskView2.maskColor = [UIColor greenColor];
        _maskView2.cornerRadius = 5;
    }
    return _maskView2;
}


@end
