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

- (void) checkEmail:(NSString *)email andPassword:(NSString *)password completion:(void(^)(BOOL succeeded, NSDictionary *userDctionary)) handler{
    
    [_service checkEmail:email andPassword:password completion:^(BOOL succeeded, NSDictionary *userDctionary) {
        if (succeeded) {
            handler(YES,userDctionary);
        }else{
            handler(NO,nil);
        }
    }];
}

- (void) searchReastaurants:(NSString *)address completion:(void(^) (NSArray *restaurants)) handler{
 
    NSArray *restaurantInfo= [_service searchReastaurants:address];
    
    handler(restaurantInfo);    
}


- (void) restaurantDetails: (NSString *) restaurantID completion: (void (^) (NSDictionary * restaurant)) callback{
    
    NSDictionary *restaurantDetails=[_service restaurantDetails:restaurantID];
    callback(restaurantDetails);
}

@end
