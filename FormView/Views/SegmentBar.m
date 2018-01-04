//
//  SegmentBar.m
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "SegmentBar.h"

@interface SegmentBarCellItem : NSObject

@end

@implementation SegmentBarCellItem

@end

@interface SegmentBarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation SegmentBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
    }
    return _textLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

@end


@interface SegmentBar()
<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSValue *>*titleSize;

@end

@implementation SegmentBar

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        self.titleFont = [UIFont systemFontOfSize:13];

        self.titleSize = [NSMutableDictionary dictionary];

        [self registerClass:[SegmentBarCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SegmentBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.titles[indexPath.row];
    return [self calculateSizeWithTitle:title];
}

- (CGSize)calculateSizeWithTitle:(nonnull NSString *)title {
    CGSize size = self.titleSize[title].CGSizeValue;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = [title boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesFontLeading
                                attributes:@{NSForegroundColorAttributeName: self.titleFont}
                                   context:nil].size;
        self.titleSize[title] = [NSValue valueWithCGSize:size];
    }
    return size;
}

@end
