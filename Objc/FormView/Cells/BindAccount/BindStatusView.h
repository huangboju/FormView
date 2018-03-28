//
//  BindStatusView.h
//  FormView
//
//  Created by 黄伯驹 on 27/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BindStatusViewItem : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *socialType;

@end

@interface BindStatusView : UIView

- (void)updateViewData:(NSArray <BindStatusViewItem *>*)viewData;

@end
