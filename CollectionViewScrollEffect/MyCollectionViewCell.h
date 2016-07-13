//
//  MyCollectionViewCell.h
//  LRPerceivedErrorEffect
//
//  Created by GML on 16/7/13.
//  Copyright © 2016年 scorpio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImg;

@property (nonatomic,copy) NSString *imgName;

- (void)cellOnCollectionView:(UICollectionView *)collectionView didScrollView:(UIView *)view;

@end
