//
//  SegmentBar.m
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "XYSegmentControl.h"

#pragma mark - SegmentBarCellItem

@interface XYSegmentControlCellItem()

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, strong) UIFont *textFont;

@end


@implementation XYSegmentControlCellItem

@end

#pragma mark - SegmentBarCell

@interface XYSegmentControlItemCell : UICollectionViewCell <XYSegmentBarCellUpdatable>

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XYSegmentControlItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self.contentView addSubview:self.textLabel];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)updateViewData:(XYSegmentControlCellItem *)viewData {
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

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = UIImageView.new;
    }
    return _imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = self.bounds;
    self.imageView.frame = self.bounds;
}

@end


#pragma mark - SegmentBar

@interface XYSegmentControl()
<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>

@property (nonatomic, strong) NSMutableDictionary <NSString *, NSValue *>*titleSizeCache;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, assign) BOOL isFirst;


@property (nonatomic) CGFloat indicatorMinX;

@property (nonatomic) CGFloat indicatorWidth;

@end

@implementation XYSegmentControl

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithSectionTitles:(NSArray<NSString *> *)sectiontitles {
    if (self = [super initWithFrame:CGRectZero]) {
        [self commonInit];
        self.sectionTitles = sectiontitles;
    }
    return self;
}

- (id)initWithSectionImages:(NSArray<UIImage *> *)sectionImages
      sectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages {
    if (self = [super initWithFrame:CGRectZero]) {
        [self commonInit];
        self.sectionImages = sectionImages;
        self.sectionSelectedImages = sectionSelectedImages;
    }

    return self;
}

- (instancetype)initWithSectionImages:(NSArray<UIImage *> *)sectionImages
                sectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages titlesForSections:(NSArray<NSString *> *)sectiontitles {
    
    if (self = [super initWithFrame:CGRectZero]) {
        [self commonInit];
        
        if (sectionImages.count != sectiontitles.count) {
            [NSException raise:NSRangeException format:@"***%s: Images bounds (%ld) Don't match Title bounds (%ld)", sel_getName(_cmd), (unsigned long)sectionImages.count, (unsigned long)sectiontitles.count];
        }

        self.sectionImages = sectionImages;
        self.sectionSelectedImages = sectionSelectedImages;
        self.sectionTitles = sectiontitles;
    }
    
    return self;
}

- (void)commonInit {

        self.selectionIndicatorHeight = 2;
        self.indicatorInterval = 8;
        self.titleInterval = 8;
        self.selectedSegmentIndex = 0;
        self.selectionIndicatorColor = [UIColor blackColor];

        self.selectionIndicatorEdgeInsets = UIEdgeInsetsZero;

        self.isFirst = YES;

        self.titleSizeCache = [NSMutableDictionary dictionary];

        [self addSubview:self.collectionView];

        [self.collectionView addSubview:self.indicator];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.collectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
}

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles {
    _sectionTitles = sectionTitles;
    
}

- (void)setSectionImages:(NSArray<UIImage *> *)sectionImages {
    _sectionImages = sectionImages;
}

- (void)setSectionSelectedImages:(NSArray<UIImage *> *)sectionSelectedImages {
    _sectionSelectedImages = sectionSelectedImages;
}

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    self.indicator.backgroundColor = selectionIndicatorColor;
}

- (UIColor *)selectionIndicatorColor {
    return self.indicator.backgroundColor;
}

- (void)setTitleInterval:(CGFloat)titleInterval {
    _titleInterval = titleInterval;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = titleInterval;
    self.collectionView.collectionViewLayout = layout;
}

- (void)setSelectedSegmentIndex:(NSInteger)index {
    [self setSelectedSegmentIndex:index animated:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    _selectedSegmentIndex = index;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
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
    return self.sectionTitles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell <XYSegmentBarCellUpdatable> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateViewData:[self generateItemAtIndexPath:indexPath]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentBar:didSelectItemAtIndex:)]) {
        [self.delegate segmentBar:self didSelectItemAtIndex:indexPath.row];
    }

    [self setSelectedSegmentIndex:indexPath.row animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self measureTitleAtIndex:indexPath];
}

- (CGSize)measureTitleAtIndex:(nonnull NSIndexPath *)indexPath {
    NSString *title = self.sectionTitles[indexPath.row];
    CGSize size = self.titleSizeCache[title].CGSizeValue;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = [title boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)
                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                attributes:self.resultingTitleTextAttributes
                                   context:nil].size;

        CGRect rect = self.collectionView.frame;
        if (rect.size.height != size.height) {
            // 主要为了设置collectionview的高度和indicator的y坐标，一次就好
            rect.size.height = size.height;
            self.collectionView.frame = rect;
            self.indicatorWidth = size.width;
            [self updateIndicatorWithAnimation:YES];
        }
        self.titleSizeCache[title] = [NSValue valueWithCGSize:size];
    }
    return size;
}

- (void)updateBottomIndicatorWithScrollView:(UIScrollView *)scrollView isLeft:(BOOL)isLeft {

    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scrollViewWidth = CGRectGetWidth(scrollView.frame);

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
    
    CGFloat selectedIndexMinx = CGRectGetMinX([self rectForSegmentAtIndex:fromIndex]);
    CGFloat selectedIndexWidth = CGRectGetWidth([self rectForSegmentAtIndex:fromIndex]);

    CGFloat targetIndexMinx = CGRectGetMinX([self rectForSegmentAtIndex:toIndex]);
    CGFloat targetIndexWidth = CGRectGetWidth([self rectForSegmentAtIndex:toIndex]);

    self.indicatorMinX = (targetIndexMinx - selectedIndexMinx) * progress + selectedIndexMinx;
    self.indicatorWidth = (targetIndexWidth - selectedIndexWidth) * progress + selectedIndexWidth;

    [self updateIndicatorWithAnimation:NO];

    self.selectedSegmentIndex = toIndex;
}

- (CGRect)rectForSegmentAtIndex:(NSUInteger)index {
    NSInteger idx = MIN(MAX(index, 0), self.sectionTitles.count - 1);
    return [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]].frame;
}

- (void)updateIndicatorWithAnimation:(BOOL)animation {
    CGFloat indicatorY = CGRectGetMaxY(self.collectionView.frame) + self.indicatorInterval;

    dispatch_block_t block = ^{
        CGRect rect = self.indicator.frame;
        rect.origin.x = self.indicatorMinX;
        rect.origin.y = indicatorY;
        rect.size.width = self.indicatorWidth;
        rect.size.height = self.selectionIndicatorHeight;
        self.indicator.frame = rect;
    };

    if (animation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:block completion:nil];
    } else {
        block();
    }
}

- (NSDictionary *)resultingTitleTextAttributes {
    NSDictionary *defaults = @{
        NSFontAttributeName : [UIFont systemFontOfSize:17.0f],
        NSForegroundColorAttributeName : [UIColor colorWithRed:51.f / 255.f green:51.f / 255.f blue:51.f / 255.f alpha:1],
    };

    NSMutableDictionary *resultingAttrs = [NSMutableDictionary dictionaryWithDictionary:defaults];
    
    if (self.titleTextAttributes) {
        [resultingAttrs addEntriesFromDictionary:self.titleTextAttributes];
    }

    return [resultingAttrs copy];
}

- (NSDictionary *)resultingSelectedTitleTextAttributes {
    NSMutableDictionary *resultingAttrs = self.resultingTitleTextAttributes.mutableCopy;

    if (self.selectedTitleTextAttributes) {
        [resultingAttrs addEntriesFromDictionary:self.selectedTitleTextAttributes];
    }
    
    return [resultingAttrs copy];
}

- (XYSegmentControlCellItem *)generateItemAtIndexPath:(NSIndexPath *)indexPath {
    XYSegmentControlCellItem *item = [XYSegmentControlCellItem new];
//    item.textFont = self.titleFont;
//    item.textColor = self.titleColor;
    item.text = self.sectionTitles[indexPath.row];
    return item;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.clipsToBounds = NO;
        _collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:XYSegmentControlItemCell.class forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}

- (UIView *)indicator {
    if (!_indicator) {
        _indicator = [UIView new];
    }
    return _indicator;
}

@end

