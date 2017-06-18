//
//  DisplayNearestRestaurantsViewController.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface DisplayNearestRestaurantsViewController : UICollectionViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLGeocoder *coder;
@property (weak, nonatomic) UICollectionViewController *collectionViewController;

@end
