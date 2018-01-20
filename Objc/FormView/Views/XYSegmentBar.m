//
//  SegmentBar.m
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYSegmentBar.h"

#pragma mark - SegmentBarCellItem

@implementation XYSegmentBarCellItem

@end

#pragma mark - SegmentBarCell

@interface SegmentBarCell : UICollectionViewCell <XYSegmentBarCellUpdatable>

@property (nonatomic, strong) UILabel *textLabel;

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

- (void)updateViewData:(XYSegmentBarCellItem *)viewData {
    self.textLabel.text = viewData.text;
    self.textLabel.textColor = viewData.textColor;
    self.textLabel.font = viewData.textFont;
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

@interface XYSegmentBar()
<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSValue *>*titleSize;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *bottomIndicator;

@property (nonatomic, assign) BOOL isFirst;

@property (nonatomic, assign) NSInteger selectedIndex;


@property (nonatomic) CGFloat indicatorMinX;

@property (nonatomic) CGFloat indicatorWidth;

@property (nonatomic, weak) id(^configHandle)(XYSegmentBarCellItem *);

@end

@implementation XYSegmentBar

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.titles = titles;

        self.indicatorHeight = 2;
        self.indicatorInterval = 8;
        self.titleInterval = 8;
        self.selectedIndex = 0;
        self.indicatorBackgrounColor = [UIColor blackColor];

        [self customCellWithCellClass:[SegmentBarCell class] configHandle:^id(XYSegmentBarCellItem *item) {
            return item;
        }];

        self.isFirst = YES;

        self.titleFont = [UIFont systemFontOfSize:17];
        self.titleColor = [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1];

        self.titleSize = [NSMutableDictionary dictionary];

        [self addSubview:self.collectionView];

        [self.collectionView addSubview:self.bottomIndicator];
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
    }
    return _collectionView;
}

- (UIView *)bottomIndicator {
    if (!_bottomIndicator) {
        _bottomIndicator = [UIView new];
    }
    return _bottomIndicator;
}

- (void)setIndicatorBackgrounColor:(UIColor *)indicatorBackgrounColor {
    _indicatorBackgrounColor = indicatorBackgrounColor;
    self.bottomIndicator.backgroundColor = indicatorBackgrounColor;
}

- (void)customCellWithCellClass:(Class)cellClass configHandle:(id (^)(XYSegmentBarCellItem *item))handle {
    
    self.configHandle = handle;

    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:@"cell"];
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

- (void)setCurrentTabIndex:(NSUInteger)currentTabIndex animated:(BOOL)animated {
    self.selectedIndex = currentTabIndex;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectedIndex inSection:0];
    dispatch_block_t block = ^{
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
        CGRect newRect = cell.frame;
        self.indicatorMinX = newRect.origin.x;
        self.indicatorWidth = cell.frame.size.width;
        [self updateIndicatorWithAnimation:animated];
    };

    if (self.isFirst) {
        // 第一次进来cell没有画出来
        self.isFirst = NO;
        dispatch_async(dispatch_get_main_queue(), block);
    } else {
        block();
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.collectionView.backgroundColor = backgroundColor;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(XYSegmentBarCellUpdatable)]) {
        id item = [self generateItemAtIndexPath:indexPath];
        if (self.configHandle) {
            item = self.configHandle(item);
        }
        [cell performSelector:@selector(updateViewData:) withObject:item];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didSelectItemAtIndex:)]) {
        [self.delegate segmentBar:self didSelectItemAtIndex:indexPath.row];
    }

    [self setCurrentTabIndex:indexPath.row animated:YES];
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

- (void)updateBottomIndicatorWithScrollView:(UIScrollView *)scrollView isLeft:(BOOL)isLeft {

    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scrollViewWidth = scrollView.frame.size.width;

    CGFloat progress = fmodf(offsetX, scrollViewWidth) / scrollViewWidth;

    NSInteger fromIndex = 0;
    NSInteger toIndex = 0;
    
    if (isLeft) {
        fromIndex = floor(offsetX / scrollViewWidth);
        toIndex = fromIndex + 1;
    } else {
        toIndex = floor(offsetX / scrollViewWidth);
        if (offsetX <= 0) {
            toIndex = 0;
        }
        fromIndex = toIndex + 1;
        progress = 1 - progress;
    }

    CGFloat selectedIndexMinx = [self getCGRectForSegmentAtIndex:fromIndex].origin.x;
    CGFloat selectedIndexWidth = [self getCGRectForSegmentAtIndex:fromIndex].size.width;

    CGFloat targetIndexMinx = [self getCGRectForSegmentAtIndex:toIndex].origin.x;
    CGFloat targetIndexWidth = [self getCGRectForSegmentAtIndex:toIndex].size.width;

    self.indicatorMinX = (targetIndexMinx - selectedIndexMinx) * progress + selectedIndexMinx;
    self.indicatorWidth = (targetIndexWidth - selectedIndexWidth) * progress + selectedIndexWidth;

    [self updateIndicatorWithAnimation:NO];

    self.selectedIndex = toIndex;
}

- (CGRect)getCGRectForSegmentAtIndex:(NSUInteger)index {
    index = MIN(MAX(index, 0), self.titles.count - 1);
    return [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]].frame;
}

- (void)updateIndicatorWithAnimation:(BOOL)animation {
    CGFloat indicatorY = CGRectGetMaxY(self.collectionView.frame) + self.indicatorInterval;

    dispatch_block_t block = ^{
        CGRect rect = self.bottomIndicator.frame;
        rect.origin.x = self.indicatorMinX;
        rect.origin.y = indicatorY;
        rect.size.width = self.indicatorWidth;
        rect.size.height = self.indicatorHeight;
        self.bottomIndicator.frame = rect;
    };

    if (animation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:block completion:nil];
    } else {
        block();
    }
}

- (XYSegmentBarCellItem *)generateItemAtIndexPath:(NSIndexPath *)indexPath {
    XYSegmentBarCellItem *item = [XYSegmentBarCellItem new];
    item.textFont = self.titleFont;
    item.textColor = self.titleColor;
    item.text = self.titles[indexPath.row];
    return item;
}

@end
