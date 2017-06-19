//
//  DisplayNearestRestaurantPresenter.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplayNearestRestaurantServiceProtocol.h"
#import "DisplayNearestRestaurantPresenterProtocol.h"

@protocol DisplayNearestRestaurantPresenterDelegate <NSObject>


@end

@interface DisplayNearestRestaurantPresenter : NSObject


@property (strong, nonatomic) id<DisplayNearestRestaurantPresenterDelegate> delegate;
@property (weak, nonatomic) id<DisplayNearestRestaurantServiceProtocol> service;

- (instancetype)initWithService: (id<DisplayNearestRestaurantServiceProtocol>) service;
- (void) registerNewCustomer:(NSMutableDictionary *) userDetails;

- (void) checkEmail:(NSString *)email andPassword:(NSString *)password completion:(void(^)(BOOL succeeded))handler;

@end
