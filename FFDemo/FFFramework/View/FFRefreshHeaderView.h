//
//  FFRefreshHeaderView.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFConst.h"

@interface FFRefreshHeaderView : UIView
@property (nonatomic) RefreshViewState state;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end
