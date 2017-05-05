//
//  BookCell.m
//  FFDemo
//
//  Created by VS on 2017/5/3.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "BookCell.h"

#import "TestModel.h"

#import "FFConst.h"

#import "UIView+FFView.h"
#import "UIImageView+WebCache.h"

static NSString *BookCellID = @"BookCellID";

@interface BookCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bookImgView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bookPublisherLabel;

@end

@implementation BookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bookImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.bookImgView.clipsToBounds = YES;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    BookCell *cell = [tableView dequeueReusableCellWithIdentifier:BookCellID];
    if (cell == nil) {
        cell = [BookCell loadFromNib];
    }
    return cell;
}

- (void)setBook:(TestModel *)book {
    _book = book;
    [self.bookImgView sd_setImageWithURL:UrlWithString(book.image) placeholderImage:nil];
    self.bookTitleLabel.text = book.title;
    self.bookPriceLabel.text = book.price;
    self.bookPublisherLabel.text = book.publisher;
}

@end
