//
//  MapsViewController.m
//  easy-food
//
//  Created by Trainee_user on 6/23/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "MapsViewController.h"
#import "StuffTableViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MapsViewController ()<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtStuff;
@property (weak, nonatomic) IBOutlet UITextField *txtZipCode;
@property (strong, nonatomic) CLLocationManager *manager;
@property (strong, nonatomic) CLGeocoder *geoCoder;

@end

@implementation MapsViewController

- (IBAction)getCurrentLocation:(id)sender {
    
    self.manager = [[CLLocationManager alloc] init];
    self.manager.delegate = self;
    self.geoCoder = [[CLGeocoder alloc] init];
    
    if ([self.manager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.manager requestWhenInUseAuthorization];
    } else {
        [self.manager startUpdatingLocation];
        
    }
    
    //    [self.geoCoder geocodeAddressString:@"20770" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    //
    //        if (!error) {
    //
    //            CLPlacemark *placemark = placemarks.firstObject;
    //
    //            NSLog(@"Placemark= %@", placemark.location);
    //            NSLog(@"Whole class= %@", placemark);
    //        } else{
    //
    //            NSLog(@"error= %@", error);
    //        }
    //
    //
    //    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.manager startUpdatingLocation];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //NSLog(@"%@", [locations objectAtIndex:0]);
    
    CLLocation *location = [locations objectAtIndex:0];
    
    [self.geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (!error) {
            CLPlacemark *place = [placemarks objectAtIndex:0];
            self.txtZipCode.text = place.postalCode;
            //NSLog(@"%@", place);
        } else{
            self.txtZipCode.text = @"No location found";
            
        }
        
        
    }];
    
    
    
    
    [self.manager stopUpdatingLocation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    StuffTableViewController *stuffVC = segue.destinationViewController;
    stuffVC.stuff = self.txtStuff.text;
    stuffVC.zipcode  = self.txtZipCode.text;
}

@end
