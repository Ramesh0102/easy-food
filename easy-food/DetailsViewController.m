//
//  DetailsViewController.m
//  easy-food
//
//  Created by Trainee_user on 6/23/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "DetailsViewController.h"
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *theMapView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = [self.currentStuff objectForKey:@"Title"];
    
    // 48.8556785,2.3312903
    
    double lat = [[self.currentStuff objectForKey:@"Latitude"] doubleValue];
    double lng = [[self.currentStuff objectForKey:@"Longitude"] doubleValue];
    
    [self.theMapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(lat, lng), MKCoordinateSpanMake(0.001, 0.001))];
    
    //    NSObject<MKAnnotation> *ann = [[NSObject alloc] init];
    //    ann.coordinate = CLLocationCoordinate2DMake(lat, lng);
    
    MapAnnotation *mapAnn = [[MapAnnotation alloc] init];
    mapAnn.coordinate = CLLocationCoordinate2DMake(lat, lng);
    mapAnn.title = [self.currentStuff objectForKey:@"Title"];
    mapAnn.subtitle = [self.currentStuff objectForKey:@"Address"];
    [self.theMapView addAnnotation:mapAnn];
    
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
