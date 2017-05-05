//
//  BookCollectionCell.m
//  FFDemo
//
//  Created by FelixKung on 17/5/5.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "BookCollectionCell.h"

#import "TestModel.h"

#import "FFConst.h"

#import "UIView+FFView.h"
#import "UIImageView+WebCache.h"

NSString * const BookCollectionCellID = @"BookCollectionCellID";

@interface BookCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BookCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    self.imgView.clipsToBounds = YES;}

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath {
    BookCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BookCollectionCellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [BookCollectionCell loadFromNib];
    }
    return  cell;
}

- (void)setBook:(TestModel *)book {
    _book = book;
    [self.imgView sd_setImageWithURL:UrlWithString(book.image) placeholderImage:nil];
    self.titleLabel.text = book.title;
}


@end
