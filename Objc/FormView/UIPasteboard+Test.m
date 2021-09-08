//
//  UIPasteboard+Test.m
//  Roehl
//
//  Created by 黄伯驹 on 2021/9/2.
//  Copyright © 2021 Roehl. All rights reserved.
//

#import <objc/runtime.h>
#import <WebKit/WKWebView.h>
#import "UIPasteboard+Test.h"

@implementation UIPasteboard (Test)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [[UIPasteboard generalPasteboard] class];
        SEL oriSelector = @selector(setString:);
        SEL swiSelector = @selector(sw_setString:);
        SwizzleInstanceMethod(class, oriSelector, swiSelector);

        SEL oriSelector1 = @selector(setData:forPasteboardType:);
        SEL swiSelector1 = @selector(sw_setData:forPasteboardType:);
        SwizzleInstanceMethod(class, oriSelector1, swiSelector1);
    });
}

- (void)sw_setString:(NSString *)string {
    [self sw_setString:string];
    NSLog(@"%s===%@👅👅👅", __FUNCTION__, string);
}

- (void)sw_setData:(NSData *)data forPasteboardType:(NSString *)pasteboardType {
    [self sw_setData:data forPasteboardType:pasteboardType];
    NSLog(@"%s===%@🦷🦷🦷", __FUNCTION__, [NSPropertyListSerialization propertyListWithData:data options:0 format:0 error:nil]);
}

void SwizzleClassMethod(Class c, SEL orig, SEL new) {

    Method origMethod = class_getClassMethod(c, orig);
    Method newMethod = class_getClassMethod(c, new);

    c = object_getClass((id)c);

    if(class_addMethod(c, orig, method_getImplementation(newMethod), method_getTypeEncoding(newMethod)))
        class_replaceMethod(c, new, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    else
        method_exchangeImplementations(origMethod, newMethod);
}

void SwizzleInstanceMethod(Class c, SEL orig, SEL new) {

    Method originalMethod = class_getInstanceMethod(c, orig);
    Method swizzledMethod = class_getInstanceMethod(c, new);

    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end



@implementation UIApplication (Test)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL oriSelector = @selector(openURL:options:completionHandler:);
        SEL swiSelector = @selector(sw_openURL:options:completionHandler:);
        SwizzleInstanceMethod(class, oriSelector, swiSelector);

        SEL oriSelector1 = @selector(canOpenURL:);
        SEL swiSelector1 = @selector(sw_canOpenURL:);
        SwizzleInstanceMethod(class, oriSelector1, swiSelector1);
    });
}

- (void)sw_openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey,id> *)options completionHandler:(void (^)(BOOL))completion {
    [self sw_openURL:url options:options completionHandler:completion];
    NSLog(@"%s===%@ 🎃🎃🎃", __FUNCTION__, url);
}

- (BOOL)sw_canOpenURL:(NSURL *)url {
    NSLog(@"%s===%@ 🌕🌕🌕", __FUNCTION__, url);
    return [self sw_canOpenURL:url];
}

@end


@implementation NSURLRequest (Test)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL oriSelector = @selector(initWithURL:);
        SEL swiSelector = @selector(sw_initWithURL:);
        SwizzleInstanceMethod(class, oriSelector, swiSelector);
    });
}

- (instancetype)sw_initWithURL:(NSURL *)URL {
    NSLog(@"%@===🔗🔗🔗", URL);
    return [self sw_initWithURL:URL];
}

@end
