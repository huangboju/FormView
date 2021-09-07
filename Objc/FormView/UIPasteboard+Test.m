//
//  UIPasteboard+Test.m
//  Roehl
//
//  Created by 黄伯驹 on 2021/9/2.
//  Copyright © 2021 Roehl. All rights reserved.
//

#import <objc/runtime.h>
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
    NSLog(@"%@😅😅😅", string);
}

- (void)sw_setData:(NSData *)data forPasteboardType:(NSString *)pasteboardType {
    [self sw_setData:data forPasteboardType:pasteboardType];
    NSLog(@"%@😅😅😅==🦷🦷🦷", [NSPropertyListSerialization propertyListWithData:data options:0 format:0 error:nil]);
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
    });
}

- (void)sw_openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenExternalURLOptionsKey,id> *)options completionHandler:(void (^)(BOOL))completion {
    [self sw_openURL:url options:options completionHandler:completion];
    NSLog(@"%@ 🥶🥶🥶🥶", url);
}

@end


@implementation NSPropertyListSerialization (Test)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL oriSelector = @selector(propertyListWithData:options:format:error:);
        SEL swiSelector = @selector(sw_propertyListWithData:options:format:error:);

        SwizzleClassMethod(class, oriSelector, swiSelector);

        SEL oriSelector1 = @selector(dataWithPropertyList:format:options:error:);
        SEL swiSelector1 = @selector(sw_dataWithPropertyList:format:options:error:);

        SwizzleClassMethod(class, oriSelector1, swiSelector1);
    });
}

+ (id)sw_propertyListWithData:(NSData *)data options:(NSPropertyListReadOptions)opt format:(NSPropertyListFormat *)format error:(out NSError *__autoreleasing  _Nullable *)error {
    id result = [self sw_propertyListWithData:data options:opt format:format error:error];
    NSLog(@"🐖🐖🐖🐖 %@", result);
    return result;
}

+ (NSData *)sw_dataWithPropertyList:(id)plist format:(NSPropertyListFormat)format options:(NSPropertyListWriteOptions)opt error:(out NSError *__autoreleasing  _Nullable *)error {
    NSData *result = [self sw_dataWithPropertyList:plist format:format options:opt error:error];
    NSLog(@"🍑🍑🍑🍑 %@", plist);
    return result;
}

@end
