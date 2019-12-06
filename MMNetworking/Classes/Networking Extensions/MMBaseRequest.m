//
//  AFBaseRequest.m
//  cengAge
//
//  Created by Michael.Meng on 2019/3/27.
//  Copyright © 2019年 Michael.Meng All rights reserved.
//

#import "MMBaseRequest.h"
#import "MMNetworking.h"

@implementation MMBaseRequest

#pragma mark - Config Before Request -

// ex: /app/index/
- (NSString *)interfaceName;
{
    return @"";
}

- (NSDictionary *)getStaticParams;
{
    return nil;
}

- (NSDictionary *)requestHeader
{
    return nil;
}

- (NSDictionary *)responseHeader
{
    return nil;
}

// handle request http header
- (void)handleHeaderWithClient:(MMAPIClient *)client
{
    NSDictionary *requestHeader = [self requestHeader];
    if (requestHeader) {
        for (NSString *key in requestHeader.allKeys) {
            [client.requestSerializer setValue:[requestHeader valueForKey:key] forHTTPHeaderField:key];
        }
    }
}

- (NSDictionary *)handleParams:(NSMutableDictionary *)params
{
    // params
    params = params ? [NSMutableDictionary dictionaryWithDictionary:params] : [NSMutableDictionary dictionary];
    NSDictionary *staticParams = [self getStaticParams];
    if (nil != staticParams) {
        [params addEntriesFromDictionary:staticParams];
    }
    NSLog(@"request params: %@", params);
    return params;
}

#pragma mark - Start Request -
#pragma mark - GET -
+ (nullable NSURLSessionDataTask *)GETWithParameters:(nullable id)parameters
                                   showLoadingInView:(UIView *)view
                                            progress:(nullable void (^)(NSProgress *progress))downloadProgress
                                             success:(nullable void (^)(MMBaseRequest *request))success
                                             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    if (view) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        });
    }
    MMBaseRequest *request = [[self alloc] init];
    [request handleHeaderWithClient:MMShareAPIClient];
    parameters = [request handleParams:parameters];
    NSLog(@"request url: %@%@", MMShareAPIClient.baseURL.absoluteString, [request interfaceName]);
    NSURLSessionDataTask *task = [MMShareAPIClient GET:[request interfaceName]
                                            parameters:parameters
                                              progress:^(NSProgress *progress) {
                                                  NSLog(@"downloadProgress: %@", downloadProgress);
                                                  if (downloadProgress) {
                                                      downloadProgress(progress);
                                                  }
                                              }
                                               success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                                   request.task = task;
                                                   request.dataResult = [request processResponse:responseObject];
                                                   if (success) {
                                                       success(request);
                                                   }
                                                   [MBProgressHUD hideHUDForView:view animated:YES];
                                               }
                                               failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                   if (failure) {
                                                       failure(task, error);
                                                   }
                                                   [MBProgressHUD hideHUDForView:view animated:YES];
                                               }];
    return task;
}

+ (nullable NSURLSessionDataTask *)GETWithParameters:(nullable id)parameters
                                            progress:(nullable void (^)(NSProgress *progress))downloadProgress
                                             success:(nullable void (^)(MMBaseRequest *request))success
                                             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    return [self GETWithParameters:parameters
                 showLoadingInView:nil
                          progress:downloadProgress
                           success:success
                           failure:failure];
}

#pragma mark - POST -
+ (nullable NSURLSessionDataTask *)POSTWithParameters:(nullable id)parameters
                                    showLoadingInView:(UIView *)view
                            constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                             progress:(nullable void (^)(NSProgress *progress))uploadProgress
                                              success:(nullable void (^)(MMBaseRequest *request))success
                                              failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:view animated:YES];
    });
    MMBaseRequest *request = [[self alloc] init];
    [request handleHeaderWithClient:MMShareAPIClient];
    parameters = [request handleParams:parameters];
    NSLog(@"request url: %@%@", MMShareAPIClient.baseURL.absoluteString, [request interfaceName]);
    NSURLSessionDataTask *task = [MMShareAPIClient POST:[request interfaceName]
                                             parameters:parameters
                              constructingBodyWithBlock:block
                                               progress:^(NSProgress *progress) {
                                                   NSLog(@"uploadProgress: %@", uploadProgress);
                                                   if (uploadProgress) {
                                                       uploadProgress(progress);
                                                   }
                                               }
                                                success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                                    request.task = task;
                                                    request.dataResult = [request processResponse:responseObject];
                                                    if (success) {
                                                        success(request);
                                                    }
                                                    [MBProgressHUD hideHUDForView:view animated:YES];
                                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                    if (failure) {
                                                        failure(task, error);
                                                    }
                                                    [MBProgressHUD hideHUDForView:view animated:YES];
                                                }];
    return task;
}

+ (nullable NSURLSessionDataTask *)POSTWithParameters:(nullable id)parameters
                            constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                             progress:(nullable void (^)(NSProgress *progress))uploadProgress
                                              success:(nullable void (^)(MMBaseRequest *request))success
                                              failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    return [self POSTWithParameters:parameters
                  showLoadingInView:nil
          constructingBodyWithBlock:block
                           progress:uploadProgress
                            success:success
                            failure:failure];
}

+ (NSURLSessionUploadTask *)uploadTaskFromFile:(NSURL *)fileURL
                                      fromData:(nullable NSData *)bodyData
                                      progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
                             completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError  * _Nullable error))completionHandler
{
    NSURLSessionUploadTask *task = nil;
    MMBaseRequest *request = [[self alloc] init];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", MMShareAPIClient.baseURL.absoluteString, [request interfaceName]];
    NSLog(@"request url: %@", urlString);
    if (bodyData) {
        task = [MMShareAPIClient uploadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
                                              fromData:bodyData
                                              progress:uploadProgressBlock
                                     completionHandler:completionHandler];
    } else {
        task = [MMShareAPIClient uploadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
                                              fromFile:fileURL
                                              progress:uploadProgressBlock
                                     completionHandler:completionHandler];
    }
    [task resume];
    request.task = task;
    return task;
}

+ (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
                                                progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                             destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                       completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler
{
    NSURLSessionDownloadTask *task = nil;
    MMBaseRequest *request = [[self alloc] init];
    NSString *urlString = [request interfaceName];
    if (!urlString || ![urlString isKindOfClass:[NSString class]] || [@"" isEqualToString:urlString]) {
        urlString = [NSString stringWithFormat:@"%@%@", MMShareAPIClient.baseURL.absoluteString, urlString];
    }
    NSLog(@"request url: %@", urlString);
    if (resumeData) {
        task = [MMShareAPIClient downloadTaskWithResumeData:resumeData
                                                   progress:downloadProgressBlock
                                                destination:destination
                                          completionHandler:^(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                              NSLog(@"File downloaded to: %@", filePath);
                                              completionHandler(response, filePath, error);
                                          }];
    } else {
        task = [MMShareAPIClient downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]
                                                progress:downloadProgressBlock
                                             destination:destination
                                       completionHandler:^(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                           NSLog(@"File downloaded to: %@", filePath);
                                           completionHandler(response, filePath, error);
                                       }];
    }
    [task resume];
    request.task = (NSURLSessionDataTask *)task;
    return task;
}

#pragma mark -- 收到网络数据后处理结果 --
- (id  _Nullable)processResponse:(id  _Nullable)responseObject
{
    NSDictionary *resultDic = (responseObject);
    self.responseObject = responseObject;
    id dataResult = nil;
    if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]) {
        // handle code and message
        NSString *code = resultDic[REQUEST_CODE_KEY];
        NSString *description = resultDic[REQUEST_DESCRIPTION];
        _summaryResult = [[MMRequestResult alloc] initWithCode:code withMessage:description];
        NSLog(@"error msg %@", description);
        
        // handle page info
        NSDictionary *pageInfoDic = resultDic[PAGE_INFO_KEY];
        if (pageInfoDic && [pageInfoDic isKindOfClass:[NSDictionary class]]) {
            _pageInfo = [[MMPageInfoModel alloc] initWithPageNo:pageInfoDic[PAGE_INDEX_KEY]
                                                       pageSize:pageInfoDic[PAGE_SIZE_KEY]
                                                   pageTotalNum:pageInfoDic[PAGE_TOTAL_KEY]];
            NSLog(@"pageInfo description %@",_pageInfo.pageTotalNum);
        }
        
        // handle data info
        dataResult = resultDic[@"data"];
    }
    self.dataResult = dataResult;
    return [self processResultDataOtherthanSummaryResult:dataResult];
}

#pragma mark - After Request Handle -

- (id  _Nullable)processResultDataOtherthanSummaryResult:(id  _Nullable)dataResult
{
    return dataResult;
}

- (BOOL)success
{
    return [_summaryResult success];
}
@end



