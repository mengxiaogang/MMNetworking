//
//  AFPageInfoModel.m
//  cengAge
//
//  Created by Michael.Meng on 2019/3/27.
//  Copyright © 2019年 Michael.Meng All rights reserved.
//

#import "MMPageInfoModel.h"

@implementation MMPageInfoModel

- (instancetype)initWithPageNo:(NSString *)pageNum
                      pageSize:(NSString *)pageSize
                  pageTotalNum:(NSString *)pageTotalNum
{
    self = [super init];
    if (self) {
        self.pageNo = pageNum ? pageNum : PAGE_DEFAULT_ZERO;
        self.pageSize = pageSize ? pageSize : PAGE_SIZE_DEFAULT;
        self.pageTotalNum = pageTotalNum ? pageTotalNum : PAGE_DEFAULT_ZERO;
    }
    return self;
}

@end
