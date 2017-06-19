//
//  DisplayNearestRestaurantsViewController.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DisplayNearestRestaurantPresenter.h"
#import "DisplayNearestRestaurantService.h"

@interface DisplayNearestRestaurantsViewController : UICollectionViewController

@property (weak, nonatomic) UICollectionViewController *collectionViewController;
@property (strong, nonatomic) DisplayNearestRestaurantPresenter *presenter;
@property (strong, nonatomic) DisplayNearestRestaurantService *service;


@end
