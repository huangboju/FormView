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

@end

@implementation SegmentController

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(self.view.frame.size.width, 300);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        CGRect rect = self.view.frame;
        rect.origin.y = 104;
        rect.size.height -= 104;
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

    self.bar = [[SegmentBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) titles:titles];
    self.bar.selectedIndex = 1;
    [self.view addSubview:self.bar];
    
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint currentLocation = scrollView.contentOffset;
    [self.bar updateBottomIndicatorX:currentLocation.x WithAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
