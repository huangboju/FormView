//
//  SegmentBar.m
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "SegmentBar.h"

#pragma mark - SegmentBarCellItem

@interface SegmentBarCellItem : NSObject

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *textFont;

@end

@implementation SegmentBarCellItem

@end

#pragma mark - SegmentBarCell

@interface SegmentBarCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) SegmentBarCellItem *model;

@end

@implementation SegmentBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.textLabel];
    }
    return self;
}

- (void)setModel:(SegmentBarCellItem *)model {
    _model = model;
    self.textLabel.text = model.text;
    self.textLabel.textColor = model.textColor;
    self.textLabel.font = model.textFont;
}

- (UILabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
}

@end


#pragma mark - SegmentBar

@interface SegmentBar()
<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSValue *>*titleSize;

@property (nonatomic, strong) NSMutableArray <NSValue *>*cellFrames;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CALayer *bottomIndicator;

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, assign) NSInteger selectedIndex;


@property(nonatomic) CGFloat indicatorMinX;

@property(nonatomic) CGFloat indicatorWidth;

@end

@implementation SegmentBar

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.titles = titles;

        self.backgroundColor = [UIColor redColor];
        
        self.indicatorHeight = 2;
        self.indicatorInterval = 8;
        self.titleInterval = 8;
        self.selectedIndex = 0;

        self.isFirst = YES;

        self.titleFont = [UIFont systemFontOfSize:17];
        self.titleColor = [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1];

        self.titleSize = [NSMutableDictionary dictionary];
        self.cellFrames = [NSMutableArray arrayWithCapacity:self.titles.count];

        [self addSubview:self.collectionView];

        [self.collectionView.layer addSublayer:self.bottomIndicator];
    }
    return self;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.clipsToBounds = NO;
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[SegmentBarCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (CALayer *)bottomIndicator {
    if (!_bottomIndicator) {
        _bottomIndicator = [CALayer layer];
        _bottomIndicator.backgroundColor = [UIColor blackColor].CGColor;
    }
    return _bottomIndicator;
}

- (void)setTitleInterval:(CGFloat)titleInterval {
    _titleInterval = titleInterval;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = titleInterval;
    self.collectionView.collectionViewLayout = layout;
}

- (NSInteger)currentIndex {
    return self.selectedIndex;
}

- (void)setCurrentTabIndex:(NSUInteger)currentTabIndex withAnimation:(BOOL)animate {
    self.selectedIndex = currentTabIndex;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    dispatch_block_t block = ^{
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        CGRect newRect = cell.frame;
        self.indicatorMinX = newRect.origin.x;
        self.indicatorWidth = cell.frame.size.width;
        [self updateIndicatorWithAnimation:animate];
    };

    if (self.isFirst) {
        self.isFirst = NO;
        dispatch_async(dispatch_get_main_queue(), block);
    } else {
        block();
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
//    self.collectionView.backgroundColor = backgroundColor;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SegmentBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    self.cellFrames[indexPath.row] = [NSValue valueWithCGRect:cell.frame];
    cell.model = [self generateItemAtIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self setCurrentTabIndex:indexPath.row withAnimation:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self calculateTitleSizeAtIndexPath:indexPath];
}

- (CGSize)calculateTitleSizeAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *title = self.titles[indexPath.row];
    CGSize size = self.titleSize[title].CGSizeValue;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = [title boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSFontAttributeName: self.titleFont}
                                   context:nil].size;

        CGRect rect = self.collectionView.frame;
        if (rect.size.height != size.height) {
            // 主要为了设置collectionview的高度和indicator的y坐标，一次就好
            rect.size.height = size.height;
            self.collectionView.frame = rect;
            self.indicatorWidth = size.width;
            [self updateIndicatorWithAnimation:YES];
        }
        self.titleSize[title] = [NSValue valueWithCGSize:size];
    }
    return size;
}

- (void)updateBottomIndicatorX:(CGFloat)offsetX {
    
    if (self.cellFrames.count < self.selectedIndex) {
        return;
    }

    CGFloat scrollViewWidth = self.frame.size.width;

    CGFloat newX = offsetX;
    
    if (newX < 0) {
        newX = -(newX + scrollViewWidth);
    }

    CGRect selectedSegmentFrame = self.cellFrames[self.selectedIndex].CGRectValue;
    CGFloat selectedSegmentWidth = selectedSegmentFrame.size.width;
    CGFloat selectedOriginX = selectedSegmentFrame.origin.x;

    if (offsetX < 0) {
        CGFloat backTabWidth = 0;
        NSInteger backIndex = self.selectedIndex;
        if (!(--backIndex < 0)) {
            backTabWidth = [self getWidthForSegmentAtIndex:backIndex];
        }

        CGFloat minX = selectedOriginX + newX / scrollViewWidth * backTabWidth;
        self.indicatorMinX = minX;

        CGFloat widthDiff = selectedSegmentWidth - backTabWidth;
        
        CGFloat newWidth = selectedSegmentWidth + newX / scrollViewWidth * widthDiff;
        self.indicatorWidth = newWidth;
    } else {
        CGFloat nextTabWidth = 0;
        NSInteger nextIndex = self.selectedIndex;

        if (!(++nextIndex >= self.titles.count)) {
            nextTabWidth = [self getWidthForSegmentAtIndex:nextIndex];
        }
        
        CGFloat minX = selectedOriginX + newX / scrollViewWidth * selectedSegmentWidth;
        self.indicatorMinX = minX;

        CGFloat widthDiff = nextTabWidth - selectedSegmentWidth;
        
        CGFloat newWidth = selectedSegmentWidth + newX / scrollViewWidth * widthDiff;
        self.indicatorWidth = newWidth;
    }

    [self updateIndicatorWithAnimation:NO];
}

- (CGFloat)getWidthForSegmentAtIndex:(NSUInteger)index {
    return self.cellFrames[index].CGRectValue.size.width;
}

- (void)updateIndicatorWithAnimation:(BOOL)animation {
    CGFloat indicatorY = CGRectGetMaxY(self.collectionView.frame) + self.indicatorInterval;
    
    [UIView animateWithDuration:animation ? 0.3 : 0
                     animations:^{
                         CGRect rect = self.bottomIndicator.frame;
                         rect.origin.x = self.indicatorMinX;
                         rect.origin.y = indicatorY;
                         rect.size.width = self.indicatorWidth;
                         rect.size.height = self.indicatorHeight;
                         self.bottomIndicator.frame = rect;
                     }];
}

- (CGSize)getTitleSizeAtIndex:(NSInteger)index {
    index = MIN(MAX(index, 0), self.titles.count - 1);
    NSString *title = self.titles[index];
    return self.titleSize[title].CGSizeValue;
}

- (SegmentBarCellItem *)generateItemAtIndexPath:(NSIndexPath *)indexPath {
    SegmentBarCellItem *item = [SegmentBarCellItem new];
    item.textFont = self.titleFont;
    item.textColor = self.titleColor;
    item.text = self.titles[indexPath.row];
    return item;
}

@end
