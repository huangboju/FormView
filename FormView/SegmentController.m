//
//  SegmentController.m
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "SegmentController.h"

#import "XYSegmentBar.h"

@interface MySegmentBarCell : UICollectionViewCell <XYSegmentBarCellUpdatable>

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation MySegmentBarCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor blueColor];
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

@interface SegmentController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) XYSegmentBar *bar;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) CGPoint lastContentOffset;

@property (nonatomic, strong) NSArray <UIColor *>*colors;

@end

@implementation SegmentController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.itemSize = CGSizeMake(self.view.frame.size.width, 200);
        CGRect rect = self.view.frame;
        rect.origin.y = 120;
        rect.size.height = 200;
        _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    NSArray *titles = @[
                        @"头条",
                        @"新闻",
                        @"NBA",
                        @"数码",
                        @"新时代哈哈",
                        @"今天好天气",
                        @"小红书"
                        ];
    
    self.colors = @[
                    [UIColor redColor],
                    [UIColor greenColor],
                    [UIColor blueColor],
                    [UIColor yellowColor],
                    [UIColor cyanColor],
                    [UIColor brownColor],
                    [UIColor purpleColor]
                    ];

    self.bar = [[XYSegmentBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) titles:titles];
    [self.bar setCurrentTabIndex:3 animated:YES];
    [self.bar customCellWithCellClass:[MySegmentBarCell class] configHandle:^id(XYSegmentBarCellItem *item) {
        return item;
    }];

    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
    
    [self.view addSubview:self.bar];

    [self.view addSubview:self.collectionView];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = self.colors[indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.lastContentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.lastContentOffset.x < scrollView.contentOffset.x) {
        // 手指向左滑动
        [self.bar updateBottomIndicatorWithScrollView:scrollView isLeft:YES];
    } else {
        // 手指向右滑动
        [self.bar updateBottomIndicatorWithScrollView:scrollView isLeft:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
