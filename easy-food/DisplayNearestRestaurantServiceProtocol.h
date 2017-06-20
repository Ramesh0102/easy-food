//
//  DisplayNearestRestaurantServiceProtocol.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol DisplayNearestRestaurantServiceProtocol <NSObject>

- (void) addNewCustomer: (NSMutableDictionary *) customerDteails;
- (void) checkEmail:(NSString *)email andPassword:(NSString *)password completion:(void(^)(BOOL succeeded, NSDictionary *userDctionary)) handler;
- (NSDictionary *) getRestaurantDetails:(NSString *) address;

@end

