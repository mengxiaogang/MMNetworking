// MMAPIClient.h
//
// Copyright (c) 2011–2016 Alamofire Software Foundation ( http://alamofire.org/ )
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MMAPIClient.h"
#import "MMNetworking.h"

static NSString * PROJECT_DOMAIN;

@implementation MMAPIClient

+ (void)configDomain:(NSString *)domain;
{
    if (domain && [domain isKindOfClass:[NSString class]]) {
        PROJECT_DOMAIN = [domain copy];
    }
    [self sharedClient];
}

+ (instancetype)sharedClient
{
    NSAssert(PROJECT_DOMAIN, @"\nYou must config domain, You only need to configure it once at app launch finish.");
    static MMAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MMAPIClient alloc] initWithBaseURL:[NSURL URLWithString:PROJECT_DOMAIN]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        NSLog(@"base url %@", _sharedClient.baseURL);
    });
    
    return _sharedClient;
}

@end
