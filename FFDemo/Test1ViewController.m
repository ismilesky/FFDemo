//
//  Test1ViewController.m
//  FFDemo
//
//  Created by VS on 2017/4/21.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

#import "Test1ViewController.h"

#import "FFTableView.h"
#import "BookCell.h"

#import "FFConst.h"

#import "TestARequest.h"
#import "FFBaseDownloadRequest.h"

#import "NSFileManager+FFFileManager.h"

@interface Test1ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet FFTableView *tableView;

@property (strong, nonatomic) NSArray *books;
@property (assign, nonatomic) NSInteger page;
@end

@implementation Test1ViewController

- (void)viewDidLoad {
    self.navigationTitleColor = [UIColor blackColor];
    self.navigationTitle = @"网络数据请求和 TableView数据显示";
    
    [super viewDidLoad];

    // 获取网络数据，要按照顺序
    [self getNetData:YES];
    
//    [self downloadData];
}

#pragma mark - Request
- (void)getNetData:(BOOL)isRefresh {
    if ([TestARequest isRequesting]) {
        return;
    }
    __weak typeof(self) WS = self;
    
    NSInteger page = isRefresh ? 1 : _page + 1;
    NSDictionary *parameter = @{@"q": @"美女",
                                @"start": @(page),
                                @"count": @10};
    
    // 1.设置下拉刷新 （不需要的话可去掉）
    id refreshBlock = ^{
        [WS getNetData:YES];
    };
    [self.tableView setRefreshBlock:refreshBlock];
    
    // 回调成功Block
    id successBlock = ^(FFBaseRequest *request){
        
        NSLog(@"请求路径-->> %@",request.requestUrl);
        NSLog(@"请求参数-->> %@",request.requestParameters);
        NSLog(@"请求结果-->> %@",request.resultDict);
        
        // 2.设置分页数
        _page = page;
        
        // 3.获取数据
        NSArray *arrResult = request.resultDict[Key_Model];
        if (isRefresh) {
            WS.books = arrResult;
        } else {
            NSMutableArray *arrTemp = [NSMutableArray arrayWithArray:WS.books];
            [arrTemp addObjectsFromArray:WS.books];
            WS.books = arrTemp;
        }
    
        // 4.设置上拉加载（不需要可去掉）
        id moreBlock = ^ {
            [WS getNetData:NO];
        };
        [WS.tableView setMoreBlock:request.totalCount > WS.books.count ? moreBlock : nil];
        
        // 5.完成加载
        [WS.tableView didFinishedLoading];
        
        // 6.数据刷新
        [WS.tableView reloadData];
    };
    
    // 回调取消Block
    id cancleBlock = ^(FFBaseRequest *request) {
        [WS.tableView didFinishedLoading];
    };
    
    // 回调失败Block
    id failureBlock = ^(FFBaseRequest *request, NSError *error){
        [WS.tableView didFinishedLoading];
        NSLog(@"---> %@",error.localizedDescription);
    };
    [TestARequest requestParameters:parameter successBlock:successBlock cancelBlock:cancleBlock failureBlock:failureBlock];
}

- (void)downloadData {
    // http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.5.1.dmg
    NSString *path = [kCachePath stringByAppendingPathComponent:@"QQ"];
    
    if (![NSFileManager isDirectoryExist:path]) {
        [NSFileManager createDirectorysAtPath:path];
    }
    
    [FFBaseDownloadRequest downloadFileWithURLString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.5.1.dmg" downloadPath:path fileName:[NSString stringWithFormat:@"%@", @"1.zip"] progressBlock:^(float progress, NSUInteger bytesRead, unsigned long long totalRead, unsigned long long totalExpectedToRead) {
        
        NSLog(@"---------->> %f", progress);
        
    } successBlock:^(FFBaseDownloadRequest *request, id responseObject) {
        
        NSLog(@">> %@",request.filePath);
    } cancelBlock:^(FFBaseDownloadRequest *request) {
        
    } failureBlock:^(FFBaseDownloadRequest *request, NSError *error) {
        NSLog(@" ---->> %@",error.localizedDescription);
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookCell *cell = [BookCell cellWithTableView:tableView];
    cell.book = self.books[indexPath.row];
    return cell;
}



@end
