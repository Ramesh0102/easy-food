//
//  MapPinAnnotationView.m
//  easy-food
//
//  Created by Trainee_user on 6/23/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "MapPinAnnotationView.h"
#import "MapAnnotation.h"

@implementation MapPinAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.enabled = YES;
        self.canShowCallout =YES;
        MapAnnotation *ann = (MapAnnotation*) annotation;
        
        if(ann.avgRating > 3){
            
            self.image = [UIImage imageNamed:@"goldStar.png"];
            
        }
        else{
            self.image = [UIImage imageNamed:@"blueImage.gif"];
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
        self.leftCalloutAccessoryView = imageView;
        
        self.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    return self;
}

@end
