//
//  MapViewController.m
//  easy-food
//
//  Created by Trainee_user on 6/23/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "MapViewController.h"
#import "MapPinAnnotationView.h"
#import "DetailsViewController.h"


@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *map;


@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.map.delegate = self;
    
    for(NSDictionary *point in _allPoints){
        
        double lat = [[point objectForKey:@"Latitude"] doubleValue];
        double lng = [[point objectForKey:@"Longitude"] doubleValue];
        
        MapAnnotation *mapAnn = [[MapAnnotation alloc] init];
        mapAnn.coordinate = CLLocationCoordinate2DMake(lat, lng);
        mapAnn.title = [point objectForKey:@"Title"];
        mapAnn.subtitle = [point objectForKey:@"Address"];
        mapAnn.avgRating = [[[point objectForKey:@"Rating"] objectForKey:@"AverageRating"] floatValue];
        mapAnn.stuff = point;
        [self.map addAnnotation:mapAnn];
        
        
    }
    
    NSDictionary *firstPoint = [_allPoints objectAtIndex:0];
    
    double lat = [[firstPoint objectForKey:@"Latitude"] doubleValue];
    double lng = [[firstPoint objectForKey:@"Longitude"] doubleValue];
    
    [self.map setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lng), MKCoordinateSpanMake(0.02, 0.02))];
    
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MapPinAnnotationView *pin = [[MapPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"pin"];
    
    
    
    return pin;
    
    //    MapAnnotation *ann = (MapAnnotation*) annotation;
    //    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"cell"];
    //    pin.enabled = YES;
    //    pin.canShowCallout = YES;
    //
    //    if(ann.avgRating > 3){
    //
    //        pin.pinTintColor = [UIColor greenColor];
    //    }
    //    else{
    //        pin.pinTintColor = [UIColor blueColor];
    //    }
    //
    //    return pin;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    MapAnnotation *ann = view.annotation;
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    DetailsViewController *dVC = (DetailsViewController*)[mainStoryboard
                                                          instantiateViewControllerWithIdentifier: @"detailsViewController"];
    dVC.currentStuff = ann.stuff;
    [self.navigationController pushViewController:dVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
