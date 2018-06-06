//
//  UserInfoLayer.m
//  FormView
//
//  Created by xiAo_Ju on 2018/5/14.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYPHSearchResultNoteUserInfoLayer.h"
#import "UIColor+Hex.h"

@interface XYPHSearchResultNoteUserInfoLayer()

@property (nonatomic, strong) CALayer *avatarLayer;

@property (nonatomic, strong) CATextLayer *nicknameLayer;

@property (nonatomic, strong) CALayer *certifiedLayer;

@end

@implementation XYPHSearchResultNoteUserInfoLayer

- (instancetype)init {
    if (self = [super init]) {

        self.avatarSize = CGSizeMake(13, 13);
        self.font = [UIFont systemFontOfSize:11];
        self.textColor = [UIColor colorWithHex:0x999999];

        [self addSublayer:self.avatarLayer];
        [self addSublayer:self.nicknameLayer];
    }
    return self;
}

- (void)layoutSublayers {
    [super layoutSublayers];

    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGSize textSize = [self.nickname sizeWithAttributes:[self attributes]];
    CGFloat maxHeight = MAX(self.avatarSize.height, textSize.height);
    CGFloat y = (maxHeight - textSize.height) / 2;
    CGRect rect = CGRectMake(CGRectGetMaxX(self.avatarLayer.frame) + 2, y, textSize.width, textSize.height);
    self.nicknameLayer.frame = rect;

    CGRect avatarRect = self.avatarLayer.frame;
    avatarRect.origin.y = (maxHeight - avatarRect.size.height) / 2;
    self.avatarLayer.frame = avatarRect;

    CGFloat avatarMaxX = CGRectGetMaxX(rect);

    if (self.isCertified) {
        CGRect certifiedRect = self.certifiedLayer.frame;
        certifiedRect.origin = CGPointMake(avatarMaxX + 2, (maxHeight - certifiedRect.size.height) / 2);
        self.certifiedLayer.frame = certifiedRect;
    }
    
    [CATransaction commit];

    CGRect oldFrame = self.frame;
    CGFloat x = self.isCertified ? CGRectGetMaxX(self.certifiedLayer.frame) : avatarMaxX;
    oldFrame.size = CGSizeMake(x, maxHeight);
    self.frame = oldFrame;
}

- (void)setAvatar:(UIImage *)avatar {
    _avatar = avatar;
    self.avatarLayer.contents = (__bridge id _Nullable)(avatar.CGImage);
}

- (void)setNickname:(NSString *)nickname {
    _nickname = nickname;
    if (!nickname) { return; }
    
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:nickname
                                                               attributes:[self attributes]];
    self.nicknameLayer.string = attr;
}

- (void)setIsCertified:(BOOL)isCertified {
    _isCertified = isCertified;
    if (isCertified) {
        [self addSublayer:self.certifiedLayer];
    } else {
        [self.certifiedLayer removeFromSuperlayer];
    }
}

- (NSDictionary <NSAttributedStringKey, id> *)attributes {
    return @{
             NSFontAttributeName: self.font,
             NSForegroundColorAttributeName: self.textColor
             };
}

- (void)setFont:(UIFont *)font {
    _font = font;
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.nicknameLayer.font = fontRef;
    self.nicknameLayer.fontSize = font.pointSize;
    CGFontRelease(fontRef);
}

- (void)setAvatarSize:(CGSize)avatarSize {
    _avatarSize = avatarSize;
    CGRect rect = self.avatarLayer.frame;
    rect.size = avatarSize;
    self.avatarLayer.frame = rect;
}

- (CALayer *)avatarLayer {
    if (!_avatarLayer) {
        _avatarLayer = [CALayer layer];
        _avatarLayer.borderWidth = 0.5;
        _avatarLayer.contentsScale = [UIScreen mainScreen].scale;
        _avatarLayer.borderColor = [UIColor colorWithHex:0xE6E6E6].CGColor;
        _avatarLayer.cornerRadius = 6.5f;
        _avatarLayer.frame = CGRectMake(0, 0, 13, 13);
    }
    return _avatarLayer;
}

- (CATextLayer *)nicknameLayer {
    if (!_nicknameLayer) {
        _nicknameLayer = [CATextLayer layer];
        _nicknameLayer.contentsScale = [UIScreen mainScreen].scale;
    }
    return _nicknameLayer;
}

- (CALayer *)certifiedLayer {
    if (!_certifiedLayer) {
        _certifiedLayer = [CALayer layer];
        _certifiedLayer.contentsScale = [UIScreen mainScreen].scale;
        _certifiedLayer.frame = CGRectMake(0, 0, 10, 10);
        _certifiedLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"certified"].CGImage);
    }
    return _certifiedLayer;
}

@end
