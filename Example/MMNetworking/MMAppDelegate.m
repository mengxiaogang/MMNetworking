//
//  MMAppDelegate.m
//  MMNetworking
//
//  Created by mengxiaogang on 12/06/2019.
//  Copyright (c) 2019 mengxiaogang. All rights reserved.
//

#import "MMAppDelegate.h"
#import <MMNetworking/MMNetworking.h>
#import "MMTestReqeust.h"
#import "MMTestModel.h"

static NSString * PROJECT_REQUET_DOMAIN = @"https://itunes.apple.com/";

@implementation MMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self launchConfigDomain];
    [self useMMNetWorkingDemo];
    return YES;
}

#pragma mark - Request Start -
// You only need to configure it once at startup
- (void)launchConfigDomain
{
    [MMAPIClient configDomain:PROJECT_REQUET_DOMAIN];
}

- (void)useMMNetWorkingDemo
{
    [MMNetworkManager testLog:@"TestLog"];
    [self performSelector:@selector(testRequest) withObject:nil afterDelay:1];
}

- (void)testRequest
{
    [MMTestReqeust GETWithParameters:@{@"id":@""}
                   showLoadingInView:_window
                            progress:nil
                             success:^(MMBaseRequest *request) {
                                 NSLog(@"success, request %@", request);
                                 NSLog(@"success, responseObject %@", request.responseObject);
                                 
                                 [self layoutUIWithReqeust:request];
                             } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                                 NSLog(@"failure, request %@", error);
                             }];
}

- (void)layoutUIWithReqeust:(MMBaseRequest *)request
{
    MMTestModel *model = request.responseObject;
    if (model) {
        for (MMTestResultItemModel *item in model.results) {
            NSLog(@"artistId: %@", item.artistId);
            NSLog(@"artistName: %@", item.artistName);
            NSLog(@"artistViewUrl: %@", item.artistViewUrl);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
