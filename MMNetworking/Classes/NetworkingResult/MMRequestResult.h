//
//  AFRequestResult.h
//  cengAge
//
//  Created by Michael.Meng on 2019/3/27.
//  Copyright © 2019年 Michael.Meng All rights reserved.
//

#import <Foundation/Foundation.h>

#define REQUEST_CODE_KEY        @"code"
#define REQUEST_DESCRIPTION     @"msg"
#define REQUEST_SUCCESS_CODE    @"0"

@interface MMRequestResult : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *message;

- (id)initWithCode:(NSString *)code withMessage:(NSString*)message;
- (BOOL)success;
- (void)showErrorMessage;

@end
