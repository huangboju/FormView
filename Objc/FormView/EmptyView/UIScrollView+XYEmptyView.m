//
//  UIScrollView+XYEmptyView.m
//  XYEmptyDataSet
//  https://github.com/dzenbot/XYEmptyDataSet
//
//  Created by Ignacio Romero Zurbuchen on 6/20/14.
//  Copyright (c) 2016 XY Labs. All rights reserved.
//  Licence: MIT-Licence
//

#import "UIScrollView+XYEmptyView.h"
#import "XYEmptyView.h"
#import <objc/runtime.h>

@interface XYWeakObjectContainer : NSObject

@property (nonatomic, readonly, weak) id weakObject;

- (instancetype)initWithWeakObject:(id)object;

@end


#pragma mark - UIScrollView+EmptyDataSet

static char const * const kEmptyDataSetSource =     "emptyDataSetSource";
static char const * const kEmptyDataSetDelegate =   "emptyDataSetDelegate";
static char const * const kEmptyDataSetView =       "emptyDataSetView";

@interface UIScrollView ()
@property (nonatomic, readonly) XYEmptyView *emptyDataSetView;
@end

@implementation UIScrollView (XYEmptyView)

#pragma mark - Getters (Public)

- (id<XYEmptyDataSetSource>)emptyDataSetSource {
    XYWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetSource);
    return container.weakObject;
}

- (id<XYEmptyDataSetDelegate>)emptyDataSetDelegate {
    XYWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetDelegate);
    return container.weakObject;
}

- (BOOL)isEmptyDataSetVisible {
    UIView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    return view ? !view.hidden : NO;
}


#pragma mark - Getters (Private)

- (XYEmptyView *)emptyDataSetView {
    XYEmptyView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    
    if (!view) {
        view = [[XYEmptyView alloc] init];
        view.hidden = YES;

        [self setEmptyDataSetView:view];
    }
    return view;
}

- (BOOL)xy_canDisplay {
    if (self.emptyDataSetSource && [self.emptyDataSetSource conformsToProtocol:@protocol(XYEmptyDataSetSource)]) {
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]] || [self isKindOfClass:[UIScrollView class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSInteger)xy_itemsCount {
    NSInteger items = 0;
    
    // UIScollView doesn't respond to 'dataSource' so let's exit
    if (![self respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    // UITableView support
    if ([self isKindOfClass:[UITableView class]]) {
        
        UITableView *tableView = (UITableView *)self;
        id <UITableViewDataSource> dataSource = tableView.dataSource;
        
        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
            sections = [dataSource numberOfSectionsInTableView:tableView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource tableView:tableView numberOfRowsInSection:section];
            }
        }
    }
    // UICollectionView support
    else if ([self isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *collectionView = (UICollectionView *)self;
        id <UICollectionViewDataSource> dataSource = collectionView.dataSource;

        NSInteger sections = 1;
        
        if (dataSource && [dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
            sections = [dataSource numberOfSectionsInCollectionView:collectionView];
        }
        
        if (dataSource && [dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
            for (NSInteger section = 0; section < sections; section++) {
                items += [dataSource collectionView:collectionView numberOfItemsInSection:section];
            }
        }
    }
    
    return items;
}


#pragma mark - Data Source Getters

- (NSString *)xy_titleLabelString {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(titleForEmptyDataSet:)]) {
        NSString *string = [self.emptyDataSetSource titleForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSString class]], @"You must return a valid NSAttributedString object for -titleForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (UIImage *)xy_image {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(imageForEmptyDataSet:)]) {
        UIImage *image = [self.emptyDataSetSource imageForEmptyDataSet:self];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -imageForEmptyDataSet:");
        return image;
    }
    return nil;
}

- (NSString *)xy_buttonTitle {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(buttonTitleForEmptyDataSet:)]) {
        NSString *string = [self.emptyDataSetSource buttonTitleForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSString class]], @"You must return a valid NSAttributedString object for -buttonTitleForEmptyDataSet:forState:");
        return string;
    }
    return nil;
}

- (UIColor *)xy_dataSetBackgroundColor {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(backgroundColorForEmptyDataSet:)]) {
        UIColor *color = [self.emptyDataSetSource backgroundColorForEmptyDataSet:self];
        if (color) NSAssert([color isKindOfClass:[UIColor class]], @"You must return a valid UIColor object for -backgroundColorForEmptyDataSet:");
        return color;
    }
    return [UIColor colorWithRed:245.f / 255.0 green:248.f / 255.0 blue:250.f / 255.0 alpha:1];
}

- (CGFloat)xy_topInterval {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(topIntervalForEmptyDataSet:)]) {
        return [self.emptyDataSetSource topIntervalForEmptyDataSet:self];
    }
    return 100.0;
}

- (BOOL)xy_didFinishNetwork {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(didFinishNetworkForEmptyDataSet:)]) {
        return [self.emptyDataSetSource didFinishNetworkForEmptyDataSet:self];
    }
    return NO;
}


#pragma mark - Delegate Getters & Events (Private)

- (BOOL)xy_shouldDisplay {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldDisplay:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldDisplay:self];
    }
    return YES;
}

- (BOOL)xy_shouldBeForcedToDisplay {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldBeForcedToDisplay:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldBeForcedToDisplay:self];
    }
    return NO;
}

- (BOOL)xy_isScrollAllowed {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldAllowScroll:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldAllowScroll:self];
    }
    return NO;
}

- (void)xy_willAppear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetWillAppear:)]) {
        [self.emptyDataSetDelegate emptyDataSetWillAppear:self];
    }
}

- (void)xy_didAppear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetDidAppear:)]) {
        [self.emptyDataSetDelegate emptyDataSetDidAppear:self];
    }
}

- (void)xy_willDisappear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetWillDisappear:)]) {
        [self.emptyDataSetDelegate emptyDataSetWillDisappear:self];
    }
}

- (void)xy_didDisappear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetDidDisappear:)]) {
        [self.emptyDataSetDelegate emptyDataSetDidDisappear:self];
    }
}

#pragma mark - Setters (Public)

- (void)setEmptyDataSetSource:(id<XYEmptyDataSetSource>)datasource {
    if (!datasource || ![self xy_canDisplay]) {
        [self xy_invalidate];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetSource, [[XYWeakObjectContainer alloc] initWithWeakObject:datasource], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // We add method sizzling for injecting -xy_reloadData implementation to the native -reloadData implementation
    [self swizzleIfPossible:@selector(reloadData)];
    
    // Exclusively for UITableView, we also inject -xy_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}

- (void)setEmptyDataSetDelegate:(id<XYEmptyDataSetDelegate>)delegate {
    if (!delegate) {
        [self xy_invalidate];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetDelegate, [[XYWeakObjectContainer alloc] initWithWeakObject:delegate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Setters (Private)

- (void)setEmptyDataSetView:(XYEmptyView *)view {
    objc_setAssociatedObject(self, kEmptyDataSetView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Reload APIs (Public)

- (void)reloadEmptyDataSet {
    [self xy_reloadEmptyDataSet];
}


#pragma mark - Reload APIs (Private)

- (void)xy_didTapDataButton:(id)sender {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSet:didTapButton:)]) {
        [self.emptyDataSetDelegate emptyDataSet:self didTapButton:sender];
    }
}

- (UIButton *)xy_customButton {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(customButtonForEmptyDataSet:)]) {
        UIButton *view = [self.emptyDataSetSource customButtonForEmptyDataSet:self];
        if (view) NSAssert([view isKindOfClass:[UIButton class]], @"You must return a valid UIView object for -customViewForEmptyDataSet:");
        return view;
    }
    return nil;
}

- (void)xy_reloadEmptyDataSet {
    if (![self xy_canDisplay]) {
        return;
    }
    
    // 网络没有完成不显示
    if (![self xy_didFinishNetwork]) {
        return;
    }
    
    if (([self xy_shouldDisplay] && [self xy_itemsCount] == 0) || [self xy_shouldBeForcedToDisplay]) {
        // Notifies that the empty dataset view will appear
        [self xy_willAppear];
        
        XYEmptyView *view = self.emptyDataSetView;
        
        // Configure empty dataset fade in display

        if (!view.superview) {
            // Send the view all the way to the back, in case a header and/or footer is present, as well as for sectionHeaders or any other content
            if (([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]]) && self.subviews.count > 1) {
                [self insertSubview:view atIndex:0];
            }
            else {
                [self addSubview:view];
            }
        }
        view.frame = self.frame;
        view.topInterval = [self xy_topInterval];
        
        // Configure Image
        view.image = [self xy_image];
        
        // Configure title label
        view.text = [self xy_titleLabelString];
        
        // Configure button
        view.buttonTitle = [self xy_buttonTitle];
        
        UIButton *customButton = [self xy_customButton];
        if (customButton) {
            view.button = customButton;
        }

        [view.button addTarget:self action:@selector(xy_didTapDataButton:) forControlEvents:UIControlEventTouchUpInside];

        // Configure the empty dataset view
        view.backgroundColor = [self xy_dataSetBackgroundColor];
        view.hidden = NO;
        view.clipsToBounds = YES;

        [UIView performWithoutAnimation:^{
            [view layoutIfNeeded];
        }];
        
        // Configure scroll permission
        self.scrollEnabled = [self xy_isScrollAllowed];
        
        // Notifies that the empty dataset view did appear
        [self xy_didAppear];
    } else if (self.isEmptyDataSetVisible) {
        [self xy_invalidate];
    }
}

- (void)xy_invalidate {
    // Notifies that the empty dataset view will disappear
    [self xy_willDisappear];
    
    if (self.emptyDataSetView) {
        [self.emptyDataSetView removeFromSuperview];
        
        [self setEmptyDataSetView:nil];
    }
    
    self.scrollEnabled = YES;
    
    // Notifies that the empty dataset view did disappear
    [self xy_didDisappear];
}


#pragma mark - Method Swizzling

static NSMutableDictionary *_impLookupTable;
static NSString *const XYSwizzleInfoPointerKey = @"pointer";
static NSString *const XYSwizzleInfoOwnerKey = @"owner";
static NSString *const XYSwizzleInfoSelectorKey = @"selector";

// Based on Bryce Buchanan's swizzling technique http://blog.newrelic.com/2014/04/16/right-way-to-swizzle/
// And Juzzin's ideas https://github.com/juzzin/JUSEmptyViewController

void xy_original_implementation(id self, SEL _cmd) {
    // Fetch original implementation from lookup table
    Class baseClass = xy_baseClassToSwizzleForTarget(self);
    NSString *key = xy_implementationKey(baseClass, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:XYSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self xy_reloadEmptyDataSet];
    
    // If found, call original implementation
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *xy_implementationKey(Class class, SEL selector) {
    if (!class || !selector) {
        return nil;
    }
    
    NSString *className = NSStringFromClass([class class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];
}

Class xy_baseClassToSwizzleForTarget(id target) {
    if ([target isKindOfClass:[UITableView class]]) {
        return [UITableView class];
    }
    else if ([target isKindOfClass:[UICollectionView class]]) {
        return [UICollectionView class];
    }
    else if ([target isKindOfClass:[UIScrollView class]]) {
        return [UIScrollView class];
    }
    
    return nil;
}

- (void)swizzleIfPossible:(SEL)selector {
    // Check if the target responds to selector
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    // Create the lookup table
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:3]; // 3 represent the supported base classes
    }
    
    // We make sure that setImplementation is called once per class kind, UITableView or UICollectionView.
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:XYSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:XYSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    Class baseClass = xy_baseClassToSwizzleForTarget(self);
    NSString *key = xy_implementationKey(baseClass, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:XYSwizzleInfoPointerKey];
    
    // If the implementation for this class already exist, skip!!
    if (impValue || !key || !baseClass) {
        return;
    }
    
    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod(baseClass, selector);
    IMP xy_newImplementation = method_setImplementation(method, (IMP)xy_original_implementation);
    
    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{XYSwizzleInfoOwnerKey: baseClass,
                                   XYSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   XYSwizzleInfoPointerKey: [NSValue valueWithPointer:xy_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}

@end

#pragma mark - XYWeakObjectContainer

@implementation XYWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object {
    self = [super init];
    if (self) {
        _weakObject = object;
    }
    return self;
}

@end

@interface XYEmptyViewDataSource() <XYEmptyDataSetSource>

@property (nonatomic, assign) BOOL isFinishNetwork;

@end

@implementation XYEmptyViewDataSource

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super init]) {
        scrollView.emptyDataSetSource = self;
        self.isFinishNetwork = NO;
    }
    return self;
}

- (void)didFinishNetwork {
    self.isFinishNetwork = YES;
}

- (BOOL)didFinishNetworkForEmptyDataSet:(UIScrollView *)scrollView {
    return self.isFinishNetwork;
}

- (nullable NSString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    return self.text;
}

- (nullable UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return self.image;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.backgroundColor ?: [UIColor colorWithRed:245.f / 255.f green:248.f / 255.f blue:250.f / 255.f alpha:1];
}

- (CGFloat)topIntervalForEmptyDataSet:(UIScrollView *)scrollView {
    return self.topInterval > 0 ?: 100;
}

- (UIButton *)customButtonForEmptyDataSet:(UIScrollView *)scrollView {
    return self.customButton;
}

@end
