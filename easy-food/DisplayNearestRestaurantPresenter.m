//
//  DisplayNearestRestaurantPresenter.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "DisplayNearestRestaurantPresenter.h"

@implementation DisplayNearestRestaurantPresenter

- (instancetype)initWithService:(id<DisplayNearestRestaurantServiceProtocol>) service
{
    self = [super init];
    if (self) {
        self.service=service;
    }
    return self;
}

- (void) registerNewCustomer:(NSMutableDictionary *) userDetails{
    [self.service addNewCustomer:userDetails];
}

- (void) checkEmail:(NSString *)email andPassword:(NSString *)password completion:(void(^)(BOOL succeeded, NSError *error))handler{
    
    NSString *pwd=[_service giveMePasswordIfEmailExist:email];
    
    NSError *error=nil;
    if (![pwd isEqualToString:@"nil"] ) {
        handler(YES, error);
    }else{
     //   error=@"You are not a easy-food member!";
        handler(NO, error);
    }
  //  handler(NO);
}

@end
