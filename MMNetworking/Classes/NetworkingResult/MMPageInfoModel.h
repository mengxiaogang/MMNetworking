//
//  AFPageInfoModel.h
//  cengAge
//
//  Created by Michael.Meng on 2019/3/27.
//  Copyright © 2019年 Michael.Meng All rights reserved.
//

#import <Foundation/Foundation.h>

//#define PAGE_INFO_KEY            @"pageInfo"
//#define PAGE_INDEX_KEY           @"pageNo"
//#define PAGE_TOTAL_KEY           @"pageTotalNum"
//#define PAGE_SIZE_KEY            @"pageSize"
//#define PAGE_SIZE_DEFAULT        @"10"
//#define PAGE_DEFAULT_ZERO        @"0"
//#define PAGE_NEXT_DEFAULT        @"1"

//
//#define PAGE_DEFAULT_ZERO_LIWEI  @"1" //服务端是从1开始作为第一页面的
//
////旧接口返回的字段
//#define PAGE_INDEX_KEY_OLD           @"currentPage"
//#define PAGE_TOTAL_KEY_OLD           @"totalCount"
//
//
//@interface ITTPageInfoModel : NSObject
//@property (nonatomic,strong) NSString *pageNo;
//@property (nonatomic,strong) NSString *pageSize;
//@property (nonatomic,strong) NSString *pageTotalNum;
//
//- (instancetype)initWithPageNo:(NSString *)pageNum
//                      pageSize:(NSString *)pageNum
//                  pageTotalNum:(NSString *)pageTotalNum;

#define PAGE_INFO_KEY           @"pageInfo"
#define PAGE_INDEX_KEY          @"pageNo"
#define PAGE_TOTAL_KEY          @"pageTotalNum"
#define PAGE_SIZE_KEY           @"pageSize"
#define PAGE_SIZE_DEFAULT       @"10"
//燕群服务器
#define PAGE_DEFAULT_ZERO       @"0"            //服务端是从0开始作为第一页面的
#define PAGE_NEXT_DEFAULT       @"1"
//My Company服务器
#define PAGE_17_DEFAULT_ZERO    @"1"            //服务端是从1开始作为第一页面的
#define PAGE_17_NEXT_DEFAULT    @"2"
#define PAGE_PAGENO_KEY_OLD     @"page"         //旧接口上行字段
#define PAGE_INDEX_KEY_OLD      @"currentPage"  //旧接口返回的字段
#define PAGE_TOTAL_KEY_OLD      @"totalCount"


@interface MMPageInfoModel : NSObject
@property (nonatomic,strong) NSString *pageNo;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *pageTotalNum;

- (instancetype)initWithPageNo:(NSString *)pageNum
                      pageSize:(NSString *)pageNum
                  pageTotalNum:(NSString *)pageTotalNum;

@end
