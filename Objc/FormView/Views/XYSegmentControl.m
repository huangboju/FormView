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

@property (nonatomic, assign) BOOL selected;

@property (nonatomic, copy) NSAttributedString *attributedText;

@property (nonatomic, copy) NSAttributedString *selectedAttributedText;

@end


@implementation XYSegmentControlCellItem

- (NSAttributedString *)displayAttr {
    return self.selected ? self.selectedAttributedText : self.attributedText;
}

- (UIImage *)displayImage {
    return self.selected ? self.selectedImage : self.image;
}

- (NSString *)displayImageLink {
    return self.selected ? self.selectedImageLink : self.imageLink;
}

@end


#pragma mark - SegmentBarCell

@interface XYSegmentControlItemCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XYSegmentControlItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColor.redColor;

        [self.contentView addSubview:self.textLabel];
        
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)updateViewData:(XYSegmentControlCellItem *)viewData {
    self.textLabel.attributedText = viewData.displayAttr;
    self.imageView.image = viewData.displayImage;
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
        _imageView.hidden = YES;
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

@property (nonatomic) CGFloat selectionIndicatorWidth;

@property (nonatomic, strong) NSArray <XYSegmentControlCellItem *> *items;

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

- (void)commonInit {
        _selectionIndicatorHeight = 2;
        _indicatorInterval = 8;
        _titleInterval = 8;
        _selectedSegmentIndex = 0;
        self.selectionIndicatorColor = [UIColor blackColor];

        self.isFirst = YES;

        self.titleSizeCache = [NSMutableDictionary dictionary];

        [self addSubview:self.collectionView];

        [self.collectionView addSubview:self.indicator];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.collectionView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self updateIndicatorWithAnimation:NO];
}

- (void)setSectionTitles:(NSArray<NSString *> *)sectionTitles {
    _sectionTitles = sectionTitles;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:sectionTitles.count];
    for (NSString *title in sectionTitles) {
        XYSegmentControlCellItem *item = self.titleImages[title] ?: XYSegmentControlCellItem.new;
        item.attributedText = [[NSAttributedString alloc] initWithString:title attributes:self.resultingTitleTextAttributes];
        item.selectedAttributedText = [[NSAttributedString alloc] initWithString:title attributes:self.resultingSelectedTitleTextAttributes];
        [result addObject:item];
    }
    self.items = result.copy;
    [self.collectionView reloadData];
}

- (void)setSelectionIndicatorWidth:(CGFloat)selectionIndicatorWidth {
    _selectionIndicatorWidth = selectionIndicatorWidth;
    [self updateIndicatorWithAnimation:NO];
}

- (void)setSelectionIndicatorHeight:(CGFloat)selectionIndicatorHeight {
    _selectionIndicatorHeight = selectionIndicatorHeight;
    [self updateIndicatorWithAnimation:NO];
}

- (void)setSelectionIndicatorColor:(UIColor *)selectionIndicatorColor {
    _selectionIndicatorColor = selectionIndicatorColor;
    self.indicator.backgroundColor = selectionIndicatorColor;
}


- (void)setTitleInterval:(CGFloat)titleInterval {
    _titleInterval = titleInterval;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = titleInterval;
}

- (void)setIndicatorInterval:(CGFloat)indicatorInterval {
    _indicatorInterval = indicatorInterval;
    CGRect frame = self.indicator.frame;
    frame.origin.y += self.indicatorInterval;
    self.indicator.frame = frame;
}

- (void)setSelectedSegmentIndex:(NSInteger)index {
    [self setSelectedSegmentIndex:index animated:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    _selectedSegmentIndex = index;

    dispatch_block_t block = ^{
        CGRect newRect = [self rectForSegmentAtIndex:index];
        self.indicatorMinX = newRect.origin.x;
        self->_selectionIndicatorWidth = newRect.size.width;
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
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYSegmentControlItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateViewData:self.items[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
       willDisplayCell:(UICollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedSegmentIndex == indexPath.row) {
        CGRect frame = self.indicator.frame;
        frame.origin.y = CGRectGetMaxY(cell.frame) + self.indicatorInterval;
        frame.size.width = CGRectGetWidth(cell.frame);
        self.indicator.frame = frame;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.row;
    
    self.items[self.selectedSegmentIndex].selected = NO;
    self.items[index].selected = YES;

    [self.collectionView performBatchUpdates:^{
        [self.collectionView reloadItemsAtIndexPaths:@[
            [NSIndexPath indexPathForItem:self.selectedSegmentIndex inSection:0],
            [NSIndexPath indexPathForItem:index inSection:0]
        ]];
    } completion:nil];

    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:didSelectItemAtIndex:)]) {
        [self.delegate segmentControl:self didSelectItemAtIndex:index];
    }
    
    if (self.indexChangeBlock) {
        self.indexChangeBlock(index);
    }

    [self setSelectedSegmentIndex:index animated:YES];
    
    _selectedSegmentIndex = index;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self measureTitleAtIndex:indexPath];
}

- (CGSize)measureTitleAtIndex:(nonnull NSIndexPath *)indexPath {
    NSAttributedString *attr = self.items[indexPath.row].attributedText;
    NSString *key = attr.string;
    CGSize size = self.titleSizeCache[key].CGSizeValue;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        
        size = [key boundingRectWithSize:CGSizeMake(300, CGFLOAT_MAX)
           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
        attributes:self.resultingTitleTextAttributes
           context:nil].size;

        self.titleSizeCache[key] = [NSValue valueWithCGSize:size];
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
    _selectionIndicatorWidth = (targetIndexWidth - selectedIndexWidth) * progress + selectedIndexWidth;

    [self updateIndicatorWithAnimation:NO];

    _selectedSegmentIndex = toIndex;
}

- (CGRect)rectForSegmentAtIndex:(NSUInteger)index {
    NSInteger idx = MIN(MAX(index, 0), self.sectionTitles.count - 1);
    return [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]].frame;
}

- (void)updateIndicatorWithAnimation:(BOOL)animation {

    dispatch_block_t block = ^{
        CGRect rect = self.indicator.frame;
        rect.origin.x = self.indicatorMinX;
        rect.size = CGSizeMake(self.selectionIndicatorWidth, self.selectionIndicatorHeight);
        self.indicator.layer.cornerRadius = CGRectGetHeight(rect) / 2;
        self.indicator.frame = rect;
    };

    if (animation) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:block completion:nil];
    } else {
        block();
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedSegmentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
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
        _indicator.clipsToBounds = YES;
    }
    return _indicator;
}

@end

