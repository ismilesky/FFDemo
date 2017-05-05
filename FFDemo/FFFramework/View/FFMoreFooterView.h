//
//  FFMoreFooterView.h
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFConst.h"

@protocol FFMoreFooterViewDelegate <NSObject>
- (void)loadMore;
@end

@interface FFMoreFooterView : UIView
@property (nonatomic, weak) id<FFMoreFooterViewDelegate> delegate;
@property (nonatomic) RefreshViewState state;
@end
