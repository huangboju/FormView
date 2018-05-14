//
//  NewCardController.m
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "NewCardController.h"

#import "TagLayer.h"

@interface NewCardController ()

@property (nonatomic, strong) TagLayer *tagLayer;

@end

@implementation NewCardController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view.layer addSublayer:self.tagLayer];
}

- (TagLayer *)tagLayer {
    if (!_tagLayer) {
        _tagLayer = [TagLayer layer];
        _tagLayer.image = [UIImage imageNamed:@"icon_tag_product_white_14"];
        _tagLayer.text = @"雅诗兰黛红石榴洗面奶";
        _tagLayer.frame = CGRectMake(100, 100, 100, 24);
    }
    return _tagLayer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
