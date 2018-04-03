//
//  XYPHBindAccountBindStatusView.h
//  FormView
//
//  Created by 黄伯驹 on 27/03/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYPHBindAccountBindStatusViewItem : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *socialType;

@end

@interface XYPHBindAccountBindStatusView : UIView

- (void)updateViewData:(NSArray <XYPHBindAccountBindStatusViewItem *>*)viewData;

@end
