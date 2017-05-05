//
//  TestARequest.h
//  FFDemo
//
//  Created by VS on 2017/5/3.
//  Copyright © 2017年 FelixKong. All rights reserved.
//

/**
 获取书籍信息的接口
 */

/**
GET  https://api.douban.com/v2/book/search
参数	     意义	        备注
q	    查询关键字	  q和tag必传其一
tag	    查询的tag	      q和tag必传其一
start	取结果的offset  默认为0
count	取结果的条数	  默认为20，最大为100
返回：返回status=200，
{
    "start": 0,
    "count": 10,
    "total": 30,
    "books" : [Book, ]
}
*/


#import "TestRequest.h"

@interface TestARequest : TestRequest

@end
