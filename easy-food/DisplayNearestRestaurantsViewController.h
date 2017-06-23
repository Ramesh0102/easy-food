//
//  DisplayNearestRestaurantsViewController.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayNearestRestaurantPresenter.h"
#import "DisplayNearestRestaurantService.h"
#import "CustomCollectionViewCellForHome.h"
#import <CoreLocation/CoreLocation.h>
#import "RestaurantMenuViewController.h"

@interface DisplayNearestRestaurantsViewController : UICollectionViewController<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>
@property (weak, nonatomic) UICollectionViewController *collectionViewController;
@property (strong, nonatomic) DisplayNearestRestaurantPresenter *presenter;
@property (strong, nonatomic) DisplayNearestRestaurantService *service;

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;


@property (strong, nonatomic) IBOutlet UICollectionView *colectionView;


- (IBAction)logoutClicked:(id)sender;
@property (strong, nonatomic) CLGeocoder *coder;
- (void) didEnterZip:(NSString*)zip address:(NSString*)address;
- (void) downloadIndividualRestaurantDetails: (long) row;

@end
