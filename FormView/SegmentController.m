//
//  SegmentController.m
//  FormView
//
//  Created by 黄伯驹 on 04/01/2018.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

#import "SegmentController.h"

#import "SegmentBar.h"

@interface SegmentController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) SegmentBar *bar;

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
                        @"科技",
                        @"问吧",
                        @"头条",
                        @"新闻",
                        @"NBA",
                        @"数码",
                        @"新时代哈哈",
                        @"科技",
                        @"问吧"
                        ];
    
    self.colors = @[
                    [UIColor redColor],
                    [UIColor greenColor],
                    [UIColor blueColor],
                    [UIColor yellowColor],
                    [UIColor cyanColor],
                    [UIColor brownColor],
                    ];

    self.bar = [[SegmentBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) titles:titles];
//    [self.bar setCurrentTabIndex: withAnimation:YES];
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
    
    CGPoint offset = scrollView.contentOffset;
    if (self.lastContentOffset.x < offset.x) {
        // 向左
        [self.bar updateBottomIndicatorX:offset.x WithAnimated:YES];
    } else {
        // 向右
        [self.bar updateBottomIndicatorX:-offset.x WithAnimated:YES];
    }

    self.lastContentOffset = scrollView.contentOffset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
        [self.bar setCurrentTabIndex:scrollView.contentOffset.x / scrollView.frame.size.width withAnimation:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
