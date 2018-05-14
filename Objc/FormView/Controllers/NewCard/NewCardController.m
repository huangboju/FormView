//
//  NewCardController.m
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "NewCardController.h"

#import "TagLayer.h"
#import "UserInfoLayer.h"

@interface NewCardController ()

@property (nonatomic, strong) TagLayer *tagLayer;

@property (nonatomic, strong) UserInfoLayer *userInfoLayer;

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
    self.tagLayer.text = @"雅诗兰黛红石榴洗面奶";

    self.userInfoLayer.isCertified = YES;
    self.userInfoLayer.nickname = @"哈哈😆";
    self.userInfoLayer.avatar = [UIImage imageNamed:@"avatar"];
}

- (TagLayer *)tagLayer {
    if (!_tagLayer) {
        _tagLayer = [TagLayer layer];
        _tagLayer.frame = CGRectMake(100, 100, 100, 24);
    }
    return _tagLayer;
}

- (UserInfoLayer *)userInfoLayer {
    if (!_userInfoLayer) {
        _userInfoLayer = [UserInfoLayer layer];
        _userInfoLayer.frame = CGRectMake(100, 150, 100, 24);
    }
    return _userInfoLayer;
}

@end
