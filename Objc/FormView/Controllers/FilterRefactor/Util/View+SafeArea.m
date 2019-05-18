//
//  View+SafaArea.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/1/21.
//

#import "View+SafeArea.h"

@implementation MAS_VIEW (SafeArea)

- (MASViewAttribute *)mas_safeTop {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideTop;
    } else {
        return self.mas_top;
    }
}

- (MASViewAttribute *)mas_safeBottom {
    if (@available(iOS 11.0, *)) {
        return self.mas_safeAreaLayoutGuideBottom;
    } else {
        return self.mas_bottom;
    }
}

@end
