//
//  ViewController.h
//  FormView
//
//  Created by 黄伯驹 on 2017/12/4.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Row.h"

@interface GroupTableController : UIViewController

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSArray <NSArray <Row *>*>*form;

- (Row *)rowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface GroupTableController (SubclassingHooks)

/**
 *  负责初始化和设置controller里面的view，也就是self.view的subView。目的在于分类代码，所以与view初始化的相关代码都写在这里。
 *
 *  @warning initSubviews只负责subviews的init，不负责布局。布局相关的代码应该写在 <b>viewDidLayoutSubviews</b>
 */
- (void)initSubviews;

@end
