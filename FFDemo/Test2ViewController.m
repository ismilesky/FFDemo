//
//  Test2ViewController.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "Test2ViewController.h"
#import "FFBaseShareCenter.h"

@interface Test2ViewController ()

@end

@implementation Test2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onShareBtnTap:(UIButton *)sender {
    UIImage *image = [UIImage imageNamed:@"benz.png"];
    NSData *imgData = UIImagePNGRepresentation(image);
    ShareContentInfo *shareInfo = [ShareContentInfo shareTitle:@"哈哈哈" content:@"你在干什么，什么都不说" url:@"https:www.baidu.com" imagePath:nil objData:imgData contentType:ShareContentType_Link];
    ShareType shareType = ShareType_None;
    if (sender.tag == 1) {
        shareType = ShareType_WeChat;
    } else if (sender.tag == 2) {
        shareType = ShareType_QQ;
    } else if (sender.tag == 3) {
        shareType = ShareType_WeChatTimeline;
    } else if (sender.tag == 4) {
        shareType = ShareType_Sina;
    }
    shareInfo.shareType = shareType;
    
    FFBaseShareCenter *shareCenter = [FFBaseShareCenter getShareCenterWithShareType:shareType];
    [shareCenter shareContentInfo:shareInfo successBlock:^{
        NSLog(@"分享成功");
    } cancelBlock:^(BOOL cancelled) {
        NSLog(@"取消分享");
    } failureBlock:^(NSError *error) {
        NSLog(@"分享失败 --->%@",error.localizedDescription);
    }];
}

@end
