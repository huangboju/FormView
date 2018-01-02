//
//  UIScrollView+EmptyDataSet.m
//  DZNEmptyDataSet
//  https://github.com/dzenbot/DZNEmptyDataSet
//
//  Created by Ignacio Romero Zurbuchen on 6/20/14.
//  Copyright (c) 2016 DZN Labs. All rights reserved.
//  Licence: MIT-Licence
//

#import "UIScrollView+EmptyDataSet.h"
#import "EmptyView.h"
#import <objc/runtime.h>

@interface DZNWeakObjectContainer : NSObject

@property (nonatomic, readonly, weak) id weakObject;

- (instancetype)initWithWeakObject:(id)object;

@end


#pragma mark - UIScrollView+EmptyDataSet

static char const * const kEmptyDataSetSource =     "emptyDataSetSource";
static char const * const kEmptyDataSetDelegate =   "emptyDataSetDelegate";
static char const * const kEmptyDataSetView =       "emptyDataSetView";

@interface UIScrollView () <UIGestureRecognizerDelegate>
@property (nonatomic, readonly) EmptyView *emptyDataSetView;
@end

@implementation UIScrollView (DZNEmptyDataSet)

#pragma mark - Getters (Public)

- (id<DZNEmptyDataSetSource>)emptyDataSetSource {
    DZNWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetSource);
    return container.weakObject;
}

- (id<DZNEmptyDataSetDelegate>)emptyDataSetDelegate {
    DZNWeakObjectContainer *container = objc_getAssociatedObject(self, kEmptyDataSetDelegate);
    return container.weakObject;
}

- (BOOL)isEmptyDataSetVisible {
    UIView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    return view ? !view.hidden : NO;
}


#pragma mark - Getters (Private)

- (EmptyView *)emptyDataSetView {
    EmptyView *view = objc_getAssociatedObject(self, kEmptyDataSetView);
    
    if (!view) {
        view = [EmptyView new];
        view.hidden = YES;

        [self setEmptyDataSetView:view];
    }
    return view;
}

- (BOOL)dzn_canDisplay {
    if (self.emptyDataSetSource && [self.emptyDataSetSource conformsToProtocol:@protocol(DZNEmptyDataSetSource)]) {
        if ([self isKindOfClass:[UITableView class]] || [self isKindOfClass:[UICollectionView class]] || [self isKindOfClass:[UIScrollView class]]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSInteger)dzn_itemsCount {
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

- (NSString *)dzn_titleLabelString {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(titleForEmptyDataSet:)]) {
        NSString *string = [self.emptyDataSetSource titleForEmptyDataSet:self];
        if (string) NSAssert([string isKindOfClass:[NSString class]], @"You must return a valid NSAttributedString object for -titleForEmptyDataSet:");
        return string;
    }
    return nil;
}

- (UIImage *)dzn_image {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(imageForEmptyDataSet:)]) {
        UIImage *image = [self.emptyDataSetSource imageForEmptyDataSet:self];
        if (image) NSAssert([image isKindOfClass:[UIImage class]], @"You must return a valid UIImage object for -imageForEmptyDataSet:");
        return image;
    }
    return nil;
}

- (NSString *)dzn_buttonTitleForState:(UIControlState)state {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(buttonTitleForEmptyDataSet:forState:)]) {
        NSString *string = [self.emptyDataSetSource buttonTitleForEmptyDataSet:self forState:state];
        if (string) NSAssert([string isKindOfClass:[NSString class]], @"You must return a valid NSAttributedString object for -buttonTitleForEmptyDataSet:forState:");
        return string;
    }
    return nil;
}

- (UIColor *)dzn_dataSetBackgroundColor {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(backgroundColorForEmptyDataSet:)]) {
        UIColor *color = [self.emptyDataSetSource backgroundColorForEmptyDataSet:self];
        if (color) NSAssert([color isKindOfClass:[UIColor class]], @"You must return a valid UIColor object for -backgroundColorForEmptyDataSet:");
        return color;
    }
    return [UIColor clearColor];
}

- (CGFloat)dzn_topInterval {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(topIntervalForEmptyDataSet:)]) {
        return [self.emptyDataSetSource topIntervalForEmptyDataSet:self];
    }
    return 100.0;
}


#pragma mark - Delegate Getters & Events (Private)

- (BOOL)dzn_shouldDisplay {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldDisplay:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldDisplay:self];
    }
    return YES;
}

- (BOOL)dzn_shouldBeForcedToDisplay {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldBeForcedToDisplay:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldBeForcedToDisplay:self];
    }
    return NO;
}

- (BOOL)dzn_isScrollAllowed {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetShouldAllowScroll:)]) {
        return [self.emptyDataSetDelegate emptyDataSetShouldAllowScroll:self];
    }
    return NO;
}

- (void)dzn_willAppear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetWillAppear:)]) {
        [self.emptyDataSetDelegate emptyDataSetWillAppear:self];
    }
}

- (void)dzn_didAppear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetDidAppear:)]) {
        [self.emptyDataSetDelegate emptyDataSetDidAppear:self];
    }
}

- (void)dzn_willDisappear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetWillDisappear:)]) {
        [self.emptyDataSetDelegate emptyDataSetWillDisappear:self];
    }
}

- (void)dzn_didDisappear {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSetDidDisappear:)]) {
        [self.emptyDataSetDelegate emptyDataSetDidDisappear:self];
    }
}

#pragma mark - Setters (Public)

- (void)setEmptyDataSetSource:(id<DZNEmptyDataSetSource>)datasource {
    if (!datasource || ![self dzn_canDisplay]) {
        [self dzn_invalidate];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetSource, [[DZNWeakObjectContainer alloc] initWithWeakObject:datasource], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // We add method sizzling for injecting -dzn_reloadData implementation to the native -reloadData implementation
    [self swizzleIfPossible:@selector(reloadData)];
    
    // Exclusively for UITableView, we also inject -dzn_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}

- (void)setEmptyDataSetDelegate:(id<DZNEmptyDataSetDelegate>)delegate {
    if (!delegate) {
        [self dzn_invalidate];
    }
    
    objc_setAssociatedObject(self, kEmptyDataSetDelegate, [[DZNWeakObjectContainer alloc] initWithWeakObject:delegate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Setters (Private)

- (void)setEmptyDataSetView:(EmptyView *)view {
    objc_setAssociatedObject(self, kEmptyDataSetView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


#pragma mark - Reload APIs (Public)

- (void)reloadEmptyDataSet {
    [self dzn_reloadEmptyDataSet];
}


#pragma mark - Reload APIs (Private)

- (void)dzn_didTapDataButton:(id)sender {
    if (self.emptyDataSetDelegate && [self.emptyDataSetDelegate respondsToSelector:@selector(emptyDataSet:didTapButton:)]) {
        [self.emptyDataSetDelegate emptyDataSet:self didTapButton:sender];
    }
}

- (UIButton *)dzn_customButton {
    if (self.emptyDataSetSource && [self.emptyDataSetSource respondsToSelector:@selector(customButtonForEmptyDataSet:)]) {
        UIButton *view = [self.emptyDataSetSource customButtonForEmptyDataSet:self];
        if (view) NSAssert([view isKindOfClass:[UIButton class]], @"You must return a valid UIView object for -customViewForEmptyDataSet:");
        return view;
    }
    return nil;
}

- (void)dzn_reloadEmptyDataSet {
    if (![self dzn_canDisplay]) {
        return;
    }
    
    if (([self dzn_shouldDisplay] && [self dzn_itemsCount] == 0) || [self dzn_shouldBeForcedToDisplay])
    {
        // Notifies that the empty dataset view will appear
        [self dzn_willAppear];
        
        EmptyView *view = self.emptyDataSetView;
        
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
        view.topInterval = [self dzn_topInterval];
        
        // Configure Image
        view.image = [self dzn_image];
        
        // Configure title label
        view.text = [self dzn_titleLabelString];
        
        // Configure button
        view.buttonTitle = [self dzn_buttonTitleForState:UIControlStateNormal];
        
        UIButton *customButton = [self dzn_customButton];
        if (customButton) {
            view.button = customButton;
        }

        [view.button addTarget:self action:@selector(dzn_didTapDataButton:) forControlEvents:UIControlEventTouchUpInside];

        // Configure the empty dataset view
        view.backgroundColor = [self dzn_dataSetBackgroundColor];
        view.hidden = NO;
        view.clipsToBounds = YES;

        [UIView performWithoutAnimation:^{
            [view layoutIfNeeded];
        }];
        
        // Configure scroll permission
        self.scrollEnabled = [self dzn_isScrollAllowed];
        
        // Notifies that the empty dataset view did appear
        [self dzn_didAppear];
    } else if (self.isEmptyDataSetVisible) {
        [self dzn_invalidate];
    }
}

- (void)dzn_invalidate {
    // Notifies that the empty dataset view will disappear
    [self dzn_willDisappear];
    
    if (self.emptyDataSetView) {
        [self.emptyDataSetView removeFromSuperview];
        
        [self setEmptyDataSetView:nil];
    }
    
    self.scrollEnabled = YES;
    
    // Notifies that the empty dataset view did disappear
    [self dzn_didDisappear];
}


#pragma mark - Method Swizzling

static NSMutableDictionary *_impLookupTable;
static NSString *const DZNSwizzleInfoPointerKey = @"pointer";
static NSString *const DZNSwizzleInfoOwnerKey = @"owner";
static NSString *const DZNSwizzleInfoSelectorKey = @"selector";

// Based on Bryce Buchanan's swizzling technique http://blog.newrelic.com/2014/04/16/right-way-to-swizzle/
// And Juzzin's ideas https://github.com/juzzin/JUSEmptyViewController

void dzn_original_implementation(id self, SEL _cmd) {
    // Fetch original implementation from lookup table
    Class baseClass = dzn_baseClassToSwizzleForTarget(self);
    NSString *key = dzn_implementationKey(baseClass, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:DZNSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self dzn_reloadEmptyDataSet];
    
    // If found, call original implementation
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *dzn_implementationKey(Class class, SEL selector) {
    if (!class || !selector) {
        return nil;
    }
    
    NSString *className = NSStringFromClass([class class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@",className,selectorName];
}

Class dzn_baseClassToSwizzleForTarget(id target) {
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
        Class class = [info objectForKey:DZNSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:DZNSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    Class baseClass = dzn_baseClassToSwizzleForTarget(self);
    NSString *key = dzn_implementationKey(baseClass, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:DZNSwizzleInfoPointerKey];
    
    // If the implementation for this class already exist, skip!!
    if (impValue || !key || !baseClass) {
        return;
    }
    
    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod(baseClass, selector);
    IMP dzn_newImplementation = method_setImplementation(method, (IMP)dzn_original_implementation);
    
    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{DZNSwizzleInfoOwnerKey: baseClass,
                                   DZNSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   DZNSwizzleInfoPointerKey: [NSValue valueWithPointer:dzn_newImplementation]};
    
    [_impLookupTable setObject:swizzledInfo forKey:key];
}

@end

#pragma mark - DZNWeakObjectContainer

@implementation DZNWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object {
    self = [super init];
    if (self) {
        _weakObject = object;
    }
    return self;
}

@end
