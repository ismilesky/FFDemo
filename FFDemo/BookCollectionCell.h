//
//  BookCollectionCell.h
//  FFDemo
//
//  Created by FelixKung on 17/5/5.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestModel;

extern NSString * const BookCollectionCellID;

@interface BookCollectionCell : UICollectionViewCell

@property (nonatomic, strong) TestModel *book;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;
@end
