//
//  XYPHBindAccountController.m
//  FormView
//
//  Created by xiAo_Ju on 23/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHBindAccountController.h"

#import <Masonry.h>

#import "BindAccountUIGenerator.h"

#import "UserCardCellItem.h"

#import "TitleView.h"

#import "GroupButtonView.h"


@interface XYPHBindAccountController ()
<
UserCardViewActionable,
GroupButtonViewDelegate,
UIScrollViewDelegate
>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UserCardView *userCardView1;

@property (nonatomic, strong) UserCardView *userCardView2;

@property (nonatomic, strong) TitleView *titleView1;

@property (nonatomic, strong) TitleView *titleView2;

@property (nonatomic, strong) GroupButtonView *groupButtonView;

@end

@implementation XYPHBindAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.groupButtonView];
    [self.groupButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.scrollView.mas_bottom);
        make.bottom.leading.trailing.mas_equalTo(0);
    }];
    
    
    self.titleView1 = [TitleView new];
    self.titleView1.text = @"你的手机号+86 18369956251 已被下方账号绑定";
    [self.scrollView addSubview:self.titleView1];

    UserCardCellItem *card1Item = [UserCardCellItem new];
    card1Item.isBinding = YES;
    self.userCardView1 = [BindAccountUIGenerator userCardViewWithItem:card1Item];
    self.userCardView1.delegate = self;
    [self.scrollView addSubview:self.userCardView1];
    
    [self.titleView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(0);
        make.leading.trailing.mas_equalTo(self.userCardView1);
    }];

    
    [self.userCardView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView1.mas_bottom);
        make.centerX.mas_equalTo(0);
    }];

    self.titleView2 = [TitleView new];
    self.titleView2.text = @"是否换绑至当前登录的账号";
    [self.scrollView insertSubview:self.titleView2 belowSubview:self.userCardView1];
    [self.titleView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userCardView1.wrapperView.mas_bottom);
        make.leading.trailing.mas_equalTo(self.titleView1);
    }];

    UserCardCellItem *card2Item = [UserCardCellItem new];
    self.userCardView2 = [BindAccountUIGenerator userCardViewWithItem:card2Item];
    self.userCardView2.delegate = self;
    [self.scrollView addSubview:self.userCardView2];
    [self updateUserCardView2Layout];
}

- (void)userCardView1UpdateLayout:(BOOL)isExpanding {
    if (self.userCardView2.isExpanding) {
        [self updateUserCardView2Layout];
        [self.userCardView2 setIsExpanding:NO animated:YES];
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.titleView2.alpha = isExpanding ? 0 : 1;
        [self.scrollView layoutIfNeeded];
        [self.scrollView.delegate scrollViewDidScroll:self.scrollView];
    }];
}

- (void)userCardView2UpdateLayout:(BOOL)isExpanding {
    if (self.userCardView1.isExpanding) {
        [self.userCardView1 setIsExpanding:NO animated:YES];
    }
    [UIView animateWithDuration:0.25 animations:^{
        if (isExpanding) {
            self.titleView2.alpha = 0;
            [self.userCardView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.scrollView).offset(-10);
                make.top.mas_equalTo(self.userCardView1.mas_bottom).offset(20);
                make.centerX.mas_equalTo(0);
            }];
        } else {
            self.titleView2.alpha = 1;
            [self updateUserCardView2Layout];
        }
        [self.scrollView layoutIfNeeded];
        CGPoint bottomOffset = CGPointMake(0, self.scrollView.contentSize.height - self.scrollView.bounds.size.height);
        if (bottomOffset.y > 0) {
            self.scrollView.contentOffset = bottomOffset;
        }
    }];
}

- (void)updateUserCardView2Layout {
    [self.userCardView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleView2.mas_bottom).priorityLow();
        make.top.greaterThanOrEqualTo(self.userCardView1.mas_bottom).offset(20);
        make.bottom.mas_equalTo(self.scrollView).offset(-10);
        make.centerX.mas_equalTo(0);
    }];
}

#pragma mark - UIScrollViewdelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetH = scrollView.contentSize.height - scrollView.frame.size.height;
    [self.groupButtonView setShowsShadow:scrollView.contentOffset.y < offsetH animated:YES];
}

#pragma mark - UserCardViewActionable
- (void)userCardView:(UserCardView *)userCardView didTransform:(BOOL)isExpanding {
    if (userCardView == self.userCardView1) {
        [self userCardView1UpdateLayout:isExpanding];
    } else {
        [self userCardView2UpdateLayout:isExpanding];
    }
}


#pragma mark - GroupButtonViewDelegate

- (void)groupButtonViewChangeBindingButtonClicked:(GroupButtonView *)searchBar {
    
}

- (void)groupButtonViewUnchangeBindingBtnButtonClicked:(GroupButtonView *)searchBar {
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (GroupButtonView *)groupButtonView {
    if (!_groupButtonView) {
        _groupButtonView = [GroupButtonView new];
        _groupButtonView.delegate = self;
    }
    return _groupButtonView;
}

@end
