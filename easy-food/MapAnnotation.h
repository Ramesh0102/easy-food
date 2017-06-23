//
//  MapAnnotation.h
//  easy-food
//
//  Created by Trainee_user on 6/23/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSDictionary *stuff;
@property (nonatomic, assign) float avgRating;

@end
