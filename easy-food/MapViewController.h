//
//  MapViewController.h
//  easy-food
//
//  Created by Trainee_user on 6/23/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (strong, nonatomic) NSArray *allPoints;

@end
