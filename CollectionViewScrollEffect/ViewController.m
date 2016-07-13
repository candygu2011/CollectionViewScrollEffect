//
//  ViewController.m
//  CollectionViewScrollEffect
//
//  Created by GML on 16/7/13.
//  Copyright © 2016年 star. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UIScrollViewDelegate
>

@property (nonatomic, weak)UICollectionView *perceivedErrorTableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupCollectionView];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width, self.view.bounds.size.width ) collectionViewLayout:flowLayout];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"MyCollectionViewCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    self.perceivedErrorTableView = collectionView;
    [self.view addSubview:collectionView];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"MyCollectionViewCell";
    MyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    cell.imgName = [NSString stringWithFormat:@"%zd",indexPath.item+1];
    return cell;
}

//滚动监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取表视图的可见单元格。(可见的视图)
    NSArray *visibleCells = [self.perceivedErrorTableView visibleCells];
    for (MyCollectionViewCell *cell in visibleCells) {
        [cell.backgroundImg.layer removeAllAnimations];
        [cell cellOnCollectionView:self.perceivedErrorTableView didScrollView:self.view];
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 停止1S后开启缩放功能
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSArray *visibleCells = [self.perceivedErrorTableView visibleCells];
        for (MyCollectionViewCell *cell in visibleCells) {
            [self animationScaleWithCell:cell];
        }
    });
    
}

- (void)animationScaleWithCell:(MyCollectionViewCell *)cell
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.2];
    scaleAnimation.duration = 8.0f;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.repeatCount = MAXFLOAT;
    [cell.backgroundImg.layer addAnimation:scaleAnimation forKey:@"transform.scale"];
}


//视图加载完在调用scrollViewDidScroll方法
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self scrollViewDidScroll:[[UIScrollView alloc]init]];
    
}

@end

