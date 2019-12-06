//
//  MMTestReqeust.m
//  MMNetworking_Example
//
//  Created by Michael.Meng on 2019/12/6.
//  Copyright © 2019年 Michael.Meng. All rights reserved.
//

#import "MMTestReqeust.h"
#import "MMTestModel.h"

@implementation MMTestReqeust

- (NSString *)interfaceName
{
    return @"lookup";
}

- (NSDictionary *)requestHeader
{
    return @{
             @"Content-Type": @"application/json"
             };
}

- (NSDictionary *)getStaticParams
{
    return @{
             @"id":@"414478124"
             };
}

- (id  _Nullable)processResponse:(id)responseObject
{
    MMTestModel *model = [MMTestModel mj_objectWithKeyValues:responseObject];
    NSLog(@"model %@", model.results);
    self.responseObject = model;
    return responseObject;
}



@end
