//
//  XYPHSearchResultGoodsFilterButton.m
//  AFNetworking
//
//  Created by xiAo_Ju on 2019/4/10.
//

#import <Masonry/Masonry.h>
#import "Theme.h"
#import "UIImage+Color.h"

#import "XYPHSearchResultGoodsFilterButton.h"

#import "XYPHSearchGoodsFilterGroup.h"

@interface XYPHSearchResultGoodsFilterButton()

@property (nonatomic, strong) UIImageView *borderImageView;

@property (nonatomic, strong) XYPHSearchGoodsFilterGroup *viewData;

@end

@implementation XYPHSearchResultGoodsFilterButton

- (void)updateViewData:(XYPHSearchGoodsFilterGroup *)viewData {
    _viewData = viewData;
    if (viewData.isNonSelected) {
        XYPHSearchGoodsFilterTag *filter = viewData.nonSelectedTag;
        if (filter.title.length > 0) {
            [self setTitle:filter.title forState:UIControlStateNormal];
            self.extensible = NO;
        } else if (filter.image.length > 0) {
//            [self sd_setImageWithURL:[NSURL URLWithString:filter.image] forState:UIControlStateNormal];
//            [self sd_setImageWithURL:[NSURL URLWithString:filter.selectedImage] forState:UIControlStateSelected];
            self.selectedColor = filter.selectedColor;
            self.imageOnly = YES;
        }
    } else {
        [self setTitle:viewData.title forState:UIControlStateNormal];
        self.extensible = viewData.filterTags.count > 0;
    }
    if (self.canExtensible && !self.imageOnly) {
        self.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        self.titleLabel.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        self.imageView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    }
}

- (void)setExtensible:(BOOL)extensible {
    _extensible = extensible;
    [self setTitleColor:Theme.colorGrayLevel2 forState:UIControlStateNormal];
    [self setTitleColor:Theme.colorGrayLevel1 forState:UIControlStateSelected];
    [self setBackgroundImageStyle];
    [self.titleLabel setFont:Theme.fontSmall];
    self.adjustsImageWhenHighlighted = NO;
    if (extensible) {
        [self insertSubview:self.borderImageView belowSubview:self.imageView];
        [self.borderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.mas_equalTo(0);
        }];
        [self setImage:[UIImage imageNamed:@"filter_show_more"] forState:UIControlStateNormal];
    }
}

- (void)setImageOnly:(BOOL)imageOnly {
    _imageOnly = imageOnly;
    [self setBackgroundImageStyle];
    self.adjustsImageWhenHighlighted = NO;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(CGPointMake(0, 0));
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.titleLabel.font = selected ? Theme.fontSmallBold : Theme.fontSmall;
}

- (void)setExpanding:(BOOL)expanding {
    if (!self.canExtensible) {
        return;
    }
    _expanding = expanding;
    [self setBackgroundImageStyle];
    self.borderImageView.hidden = !expanding;
    if (expanding) {
        [self setTitleColor:Theme.colorGrayLevel1 forState:UIControlStateNormal];
        if (CGAffineTransformIsIdentity(self.imageView.transform)) {
            self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
        }
    } else {
        [self setTitleColor:Theme.colorGrayLevel2 forState:UIControlStateNormal];
        if (!CGAffineTransformIsIdentity(self.imageView.transform)) {
            self.imageView.transform = CGAffineTransformIdentity;
        }
    }
}

- (void)setBackgroundImageStyle {
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 13, 0, 13);
    UIImage *normalImage = [UIImage imageNamed:@"filter_button_background_normal"];
    UIImage *selectedImage = [UIImage imageNamed:@"filter_button_background_selected"];
    [self setBackgroundImage:[normalImage resizableImageWithCapInsets:insets] forState:UIControlStateNormal];
    [self setBackgroundImage:[selectedImage resizableImageWithCapInsets:insets] forState:UIControlStateSelected];
    if (self.isImageOnly) {
        [self setBackgroundImage:[[selectedImage imageMaskedWithColor:UIColor.grayColor] resizableImageWithCapInsets:insets] forState:UIControlStateSelected];
    }
}

- (UIImageView *)borderImageView {
    if (!_borderImageView) {
        _borderImageView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"filter_button_border"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 13)]];
        _borderImageView.hidden = YES;
    }
    return _borderImageView;
}

@end
