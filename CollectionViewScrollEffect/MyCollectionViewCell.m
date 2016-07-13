//
//  MyCollectionViewCell.m
//  LRPerceivedErrorEffect
//
//  Created by GML on 16/7/13.
//  Copyright © 2016年 scorpio. All rights reserved.
//

#import "MyCollectionViewCell.h"
@interface MyCollectionViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    [UIView animateWithDuration:5 animations:^{
//       
//        self.backgroundImg.transform = CGAffineTransformMakeScale(1.3, 1.3);
//    } completion:^(BOOL finished) {
//
//            [UIView animateWithDuration:5 animations:^{
//                self.backgroundImg.transform = CGAffineTransformIdentity;
//            }];
//        
//    }];
    
}


-(void)setImgName:(NSString *)imgName
{
    _imgName = [imgName copy];
    self.backgroundImg.image = [UIImage imageNamed:imgName];
}

- (void)cellOnCollectionView:(UICollectionView *)collectionView didScrollView:(UIView *)view
{
    // 将cell的frame转换成view的Frame(为了获取每个cell的Y值)
    CGRect rect = [collectionView convertRect:self.frame toView:view];
    
    //视图的frame的一半 减去 所看到的每个CellY值(获取滚动的值)
    //以屏幕中心点为0点 获取能看到的每个Cell离中心点得值是多少
    float distanceCenter = CGRectGetWidth(view.frame)/2 - CGRectGetMinX(rect);
    
    // 图片高度 - cell的高度 (获取图片超出cell高度部分)图片肯定要比cell大，否则不会有视觉差效果
//    float difference = CGRectGetHeight(self.backgroundImg.frame) - CGRectGetHeight(self.frame);
    float difference = CGRectGetWidth(self.backgroundImg.frame) - CGRectGetWidth(self.frame);
    float imageMove = (distanceCenter / CGRectGetHeight(view.frame)) * difference;
    
    //旧的图片Frame
    CGRect imageRect = self.backgroundImg.frame;
    
    //移动
    imageRect.origin.x = imageMove - (difference/2);
    
    //新的图片Frame
    self.backgroundImg.frame = imageRect;

}


@end
