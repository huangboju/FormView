//
//  NewCardController.m
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "NewCardController.h"

#import "XYPHSearchResultNoteTagLayer.h"
#import "XYPHSearchResultNoteUserInfoLayer.h"

@interface NewCardController ()

@property (nonatomic, strong) XYPHSearchResultNoteTagLayer *tagLayer;

@property (nonatomic, strong) XYPHSearchResultNoteUserInfoLayer *userInfoLayer;

@end

@implementation NewCardController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self.view.layer addSublayer:self.tagLayer];
    
    [self.view.layer addSublayer:self.userInfoLayer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.tagLayer.image = [UIImage imageNamed:@"icon_tag_product_white_14"];
    self.tagLayer.text = @"gg你好吗你好吗你好吗你好吗你好吗你好吗你好吗";

    self.userInfoLayer.isCertified = YES;
    self.userInfoLayer.nickname = @"哈哈😆";
    self.userInfoLayer.avatar = [UIImage imageNamed:@"avatar"];
}

- (XYPHSearchResultNoteTagLayer *)tagLayer {
    if (!_tagLayer) {
        _tagLayer = [XYPHSearchResultNoteTagLayer layer];
        _tagLayer.frame = CGRectMake(100, 100, 100, 24);
    }
    return _tagLayer;
}

- (XYPHSearchResultNoteUserInfoLayer *)userInfoLayer {
    if (!_userInfoLayer) {
        _userInfoLayer = [XYPHSearchResultNoteUserInfoLayer layer];
        _userInfoLayer.frame = CGRectMake(100, 150, 100, 24);
    }
    return _userInfoLayer;
}

@end
