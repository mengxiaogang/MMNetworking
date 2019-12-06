//
//  AFRequestResult.m
//  cengAge
//
//  Created by Michael.Meng on 2019/3/27.
//  Copyright © 2019年 Michael.Meng All rights reserved.
//

#import "MMRequestResult.h"

@implementation MMRequestResult

- (id)initWithCode:(NSString *)code withMessage:(NSString *)message
{
    self = [super init];
    if (self) {
        _code = [NSString stringWithFormat:@"%@", code];
        _message = message;
    }
    return self;
}

- (BOOL)success
{
    return (_code && [REQUEST_SUCCESS_CODE isEqualToString:_code]);
}

- (void)showErrorMessage
{
    if (_message && _message.length > 0) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:_message
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"确定"
//                                                  otherButtonTitles:nil];
//        [alertView show];
    }
}

@end
