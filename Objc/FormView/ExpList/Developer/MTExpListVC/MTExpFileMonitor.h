//
//  MTExpFileMonitor.h
//  File Monitor
//
//  Created by Travis Blankenship on 3/27/14.
//  Copyright (c) 2014 Travis Blankenship. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MTExpFileMonitorChangeType)
{
    MTExpFileMonitorChangeTypeModified,
    MTExpFileMonitorChangeTypeMetadata,
    MTExpFileMonitorChangeTypeSize,
    MTExpFileMonitorChangeTypeRenamed,
    MTExpFileMonitorChangeTypeDeleted,
    MTExpFileMonitorChangeTypeObjectLink,
    MTExpFileMonitorChangeTypeRevoked
};

@protocol MTExpFileMonitorDelegate;

@interface MTExpFileMonitor : NSObject

@property (nonatomic, weak) id<MTExpFileMonitorDelegate> delegate;

- (id)initWithURL:(NSURL *)URL;

@end

@protocol MTExpFileMonitorDelegate <NSObject>
@optional

- (void)fileMonitor:(MTExpFileMonitor *)fileMonitor
       didSeeChange:(MTExpFileMonitorChangeType)changeType;

@end
