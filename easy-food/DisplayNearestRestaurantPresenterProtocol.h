//
//  DisplayNearestRestaurantPresenterProtocol.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//
#import <Foundation/Foundation.h>

@protocol DisplayNearestRestaurantPresenterProtocol <NSObject>

@required
- (void) registerNewCustomer:(NSMutableDictionary *) userDetails;

@end
