//
//  AFBaseRequest.h
//  cengAge
//
//  Created by Michael.Meng on 2019/3/27.
//  Copyright © 2019年 Michael.Meng All rights reserved.
//

#import <Foundation/Foundation.h>

@class MMRequestResult;
@class MMPageInfoModel;
@protocol AFMultipartFormData;

@interface MMBaseRequest : NSObject
@property(nonatomic, strong) NSURLSessionDataTask *task;        
@property(nonatomic, strong) id responseObject;                 // response result
@property(nonatomic, strong) MMRequestResult *summaryResult;    // summary result
@property(nonatomic, strong) MMPageInfoModel *pageInfo;         // page Info
@property(nonatomic, strong) id dataResult;                     // NSArray | NSDictionary data result

#pragma mark - Befour Request Config -
/*
 * you can config interfaceName in subclass,
 * Example: @"queryInfo/index/"
 */
- (NSString *)interfaceName;

/*
 * you can config getStaticParams in subclass
 */
- (NSDictionary *)getStaticParams;

/*
 * you can config requestHeader and responseHeader in subclass
 */
- (NSDictionary *)requestHeader;
- (NSDictionary *)responseHeader;

#pragma mark - Start Request -
/*
 * You can send get request by this way, it can not show loading
 */
+ (nullable NSURLSessionDataTask *)GETWithParameters:(nullable id)parameters
                                            progress:(nullable void (^)(NSProgress *progress))downloadProgress
                                             success:(nullable void (^)(MMBaseRequest *request))success
                                             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
/*
 * You can send get request by this way,
 * and you can control show loading by set param showLoadingInView, if nil, no loading
 */
+ (nullable NSURLSessionDataTask *)GETWithParameters:(nullable id)parameters
                                   showLoadingInView:(UIView *)view
                                            progress:(nullable void (^)(NSProgress *progress))downloadProgress
                                             success:(nullable void (^)(MMBaseRequest *request))success
                                             failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

/*
 * You can send post request by this way, it can not show loading
 */
+ (nullable NSURLSessionDataTask *)POSTWithParameters:(nullable id)parameters
                            constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                             progress:(nullable void (^)(NSProgress *progress))uploadProgress
                                              success:(nullable void (^)(MMBaseRequest *request))success
                                              failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;
/*
 * You can send post request by this way,
 * and you can control show loading by set param showLoadingInView, if nil, no loading
 */
+ (nullable NSURLSessionDataTask *)POSTWithParameters:(nullable id)parameters
                                    showLoadingInView:(UIView *)view
                            constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))block
                                             progress:(nullable void (^)(NSProgress *progress))uploadProgress
                                              success:(nullable void (^)(MMBaseRequest *request))success
                                              failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

+ (NSURLSessionUploadTask *)uploadTaskFromFile:(NSURL *)fileURL
                                      fromData:(nullable NSData *)bodyData
                                      progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgressBlock
                             completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject, NSError  * _Nullable error))completionHandler;

+ (NSURLSessionDownloadTask *)downloadTaskWithResumeData:(NSData *)resumeData
                                                progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                             destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                       completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;

#pragma mark - After Request Handle -
/*
 * handle origin responseObject data
 */
- (id  _Nullable)processResponse:(id  _Nullable)responseObject;
/*
 * handle data sets other than summary results from responseObject
 */
- (id  _Nullable)processResultDataOtherthanSummaryResult:(id  _Nullable)dataResult;
- (BOOL)success;

@end
