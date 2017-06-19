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

- (void) checkEmail:(NSString *)email andPassword:(NSString *)password completion:(void(^)(BOOL succeeded))handler{
    
    NSString *result=[_service checkEneteredEmail:email andPassword:password];
    if ([result isEqualToString:@"nil"]) {
        handler(NO);
    }else{
        handler(YES);
    }
}

- (void) getCurrentUserAddressForEmail:(NSString *) email{
    
}

- (void) getRestaurantDetails:(NSString *) email{
    
    [_service getRestaurantDetails:email];
}

@end
