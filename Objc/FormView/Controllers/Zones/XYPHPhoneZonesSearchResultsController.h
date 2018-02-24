//
//  XYPHPhoneZonesDisplayViewController.h
//  FormView
//
//  Created by 黄伯驹 on 24/02/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYPHContryItem;

@interface XYPHPhoneZonesSearchResultsController : UITableViewController <UISearchControllerDelegate>

@property (nonatomic, strong) NSArray <XYPHContryItem *>*result;

@end
