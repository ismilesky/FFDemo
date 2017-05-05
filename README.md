## FFFramework
一个基础小框架，好处多多，方便多多。 具体详细的使用请移步 [http://blog.csdn.net/ismilesky/article/details/70336614](http://blog.csdn.net/ismilesky/article/details/70336614)

## Introduct
- 主要包含了一些常用的 `category` 整理； 
- `model` 基类的使用，模型数据的使用可以继承该基类；
- 网络请求的使用，对于` AFNetworking` 的封装，可实现数据请求和网络下载；
- 第三方分享的封装，可以直接使用，分享到QQ，微信， 微博第三方平台；
- 自定义 `UITableView` 和 `UICollectionView` ，实现上拉刷新和下拉加载，自定义 `TabBar`；
-  `ViewController` 的使用。

## Usage
使用方法： 直接把FFFramework拖到项目中， 暂不支持Cocopods。

- Model

`FFbaseModel` 基类

```
- (NSDictionary *)ff_toKeyValue;
- (void)ff_modelsDidFinishConvertingToKeyValues;
- (void)ff_keyvaluesDidFinishConvertingToModels;

// 属性名替换 
+ (NSDictionary *)ff_replaceKeyFromPropertyName;
+ (NSDictionary *)ff_objectClassInArray;

// 可忽略的属性名
+ (NSArray *)ff_ignoredPropertyNames;

// 字典转模型
+ (instancetype)ff_modelFromKeyValue:(NSDictionary *)keyValue;

+ (NSArray *)ff_keyValuesFromModels:(NSArray *)models;

// 字典数组转模型数组
+ (NSArray *)ff_modelsFromKeyValues:(NSArray *)keyvalues;
+ (NSArray *)ff_allowedCodingPropertyNames;
+ (NSArray *)ff_ignoredCodingPropertyNames;
```

- Network

`FFBaseRequest` 网络请求类

Example:

```
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

```

`FFBaseDownloadRequest` 下载请求类

Example:

```
- (void)downloadData {
    // http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.5.1.dmg
    NSString *path = [kCachePath stringByAppendingPathComponent:@"QQ"];

    if (![NSFileManager isDirectoryExist:path]) {
        [NSFileManager createDirectorysAtPath:path];
    }

    [FFBaseDownloadRequest downloadFileWithURLString:@"http://dldir1.qq.com/qqfile/QQforMac/QQ_V5.5.1.dmg" downloadPath:path fileName:[NSString stringWithFormat:@"%@", @"1.zip"] progressBlock:^(float progress, NSUInteger bytesRead, unsigned long long totalRead, unsigned long long totalExpectedToRead) {
         // 下载进度
        NSLog(@"---------->> %f", progress);

    } successBlock:^(FFBaseDownloadRequest *request, id responseObject) {
        // 下载成功
       NSLog(@">> %@",request.filePath);
    } cancelBlock:^(FFBaseDownloadRequest *request) {

    } failureBlock:^(FFBaseDownloadRequest *request, NSError *error) {
        // 下载失败
        NSLog(@" ---->> %@",error.localizedDescription);
    }];
}
```

- ShareKit

`ShareContentInfo` 类设置分享信息，包含分享的类型（文字，链接等）, `FFBaseShareCenter` 分享管理类

Example:

```
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

```

- View

`FFTableView`, `FFCollectionView` 下拉刷新和上拉加载的使用

Example:

```
- (void)getRequest:(BOOL) isRefresh {
    if ([TestARequest isRequesting]) {
        return;
    }
    __weak typeof(self) WS = self;
    
    NSInteger page = isRefresh ? 1 : _page + 1;
    NSDictionary *parameter = @{@"q": @"美女",
                                @"start": @(page),
                                @"count": @10};
    // 回调成功Block
    id successBlock = ^(FFBaseRequest *request){
        // 设置分页数
        _page = page;
        
        // 获取数据
        NSArray *arrResult = request.resultDict[Key_Model];
        if (isRefresh) {
            WS.books = arrResult;
        } else {
            NSMutableArray *arrTemp = [NSMutableArray arrayWithArray:WS.books];
            [arrTemp addObjectsFromArray:WS.books];
            WS.books = arrTemp;
        }
        
        // 设置上拉加载
        [WS.collectionView isDisplayMoreView:WS.books.count < request.totalCount];
        
        // 完成加载
        [WS.collectionView didFinishedLoading];
        
        // 刷新数据
        [WS.collectionView reloadData];
    };
    
    // 回调取消Block
    id cancleBlock = ^(FFBaseRequest *request) {
        [WS.collectionView didFinishedLoading];
    };
    
    // 回调失败Block
    id failureBlock = ^(FFBaseRequest *request, NSError *error){
        [WS.collectionView didFinishedLoading];
    };
    [TestARequest requestParameters:parameter successBlock:successBlock cancelBlock:cancleBlock failureBlock:failureBlock];
}

// 需要实现的两个协议方法
#pragma mark - FFCollectionViewDelegate
- (void)collectionViewLoadMore:(FFCollectionView *)collectionView {
    [self getRequest:NO];
}

- (void)collectionViewRefresh:(FFCollectionView *)collectionView {
    [self getRequest:YES];
}
```

`FFTabBarView` 自定义TabBar, 继承 `FFTabBarView`

Example:

```
- (IBAction)onButtonTouched:(id)sender {
    [super onButtonTouched:sender];
}

- (NSArray<Class> *)getViewControllersClass {
    return @[[Test1ViewController class],[Test2ViewController class],[Test3ViewController class],[Test4ViewController class], [Test5ViewController class]];
}

+ (instancetype)getCPTabBar {
    return (SSTabBarView *)[super getTabBarView];
}

```


- ViewController

`FFBaseViewController` 基类

```
/**设置标题*/
@property (nonatomic, copy) NSString *navigationTitle;
/**设置标题颜色*/
@property (nonatomic, strong) UIColor *navigationTitleColor;
/**设置NavigationBar颜色*/
@property (nonatomic, strong) UIColor *navigationBarColor;
/**隐藏NavigationBar*/
@property (nonatomic, assign, getter=isHideNavigationBar) BOOL hideNavigationBar;
/**隐藏状态栏*/
@property (nonatomic, assign, getter=isHideStatusBar) BOOL hideStatusBar;
/**设置状态栏样式*/
@property (nonatomic, assign, getter=isStatusBarStyleDefault) BOOL statusBarStyleDefault;

@property (nonatomic, assign, getter=isNavBarColorChange) BOOL navBarColorChange;
/**左按钮*/
@property (nonatomic, strong) UIButton *leftBtn;
/**右按钮*/
@property (nonatomic, strong) UIButton *rightBtn;
/**右边多个按钮数组*/
@property (nonatomic, strong) NSArray *rightBtns;
/***/
@property (nonatomic, copy) DismissBlock dismissBlock;

/**显示返回按钮（默认返回按钮）*/
- (void)showBackBtn;

/**返回按钮点击*/
- (void)onBackBtnTap:(UIButton *)sender;

/**取消请求*/
- (void)cancelAllRequest;
+ (NSString *)classStr;

```

## Support
- 疑问或建议 [new issue](https://github.com/ismilesky/FFDemo/issues/new)
- [http://blog.csdn.net/ismilesky](http://blog.csdn.net/ismilesky)
