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
- (NSString *) giveMePasswordIfEmailExist:(NSString *) email;

@end

