//
//  DisplayNearestRestaurantService.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//


#import "DisplayNearestRestaurantService.h"
@interface DisplayNearestRestaurantService(){
    CLGeocoder *coder;
}

@end

@implementation DisplayNearestRestaurantService
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        <#statements#>
//    }
//    return self;
//}

- (void) addNewCustomer: (NSMutableDictionary *) customerDteails{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    
    RegisteredCustomers *customers=[NSEntityDescription insertNewObjectForEntityForName:@"RegisteredCustomers" inManagedObjectContext:coreDataStack.persistentContainer.viewContext];
    
    customers.fullname=[customerDteails objectForKey:@"fullname"];
    customers.email=[customerDteails objectForKey:@"email"];
    customers.password=[customerDteails objectForKey:@"password"];
    customers.address=[customerDteails objectForKey:@"address"];
    customers.city=[customerDteails objectForKey:@"city"];
    customers.zipcode=[customerDteails objectForKey:@"zipcode"];
    customers.mobile=[[customerDteails objectForKey:@"mobile"] integerValue];
    
    [coreDataStack saveContext];
    //2077 [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) checkEmail:(NSString *)email andPassword:(NSString *)password completion:(void(^)(BOOL succeeded, NSDictionary *userDctionary)) handler{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    NSManagedObjectContext *context=coreDataStack.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    fetchRequest.entity=[NSEntityDescription entityForName:@"RegisteredCustomers" inManagedObjectContext:context];
    fetchRequest.predicate=[NSPredicate predicateWithFormat:@"email == %@ AND password == %@", email, password];
    
    NSArray *result=[context executeFetchRequest:fetchRequest error:nil];
    
    if (result.count > 0 ){
        handler(YES,result[0]);
    }else{
        handler(NO,nil);
    }
}

- (NSArray *) searchReastaurants:(NSString *) address{
    
    
    CLLocationCoordinate2D coordinate=[self getLocationFromAddressString:address];
    NSLog(@"%f, %f",coordinate.latitude,coordinate.longitude);
    
    //search restaurant
    NSString *Post = [[NSString alloc] initWithFormat:@"{Page:0, Take:10}"];
    NSData *PostData = [Post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *zomatokey=@"b911890e669706c34d302c47f3709db6";
    NSString *str=[NSString stringWithFormat:@"https://developers.zomato.com/api/v2.1/search?start=0&count=20&lat=%f&lon=%f&radius=8046.72&cuisines=1%%2C3%%2C25%%2C148%%2C73%%2C82%%2C308&category=1%%2C13&sort=rating",coordinate.latitude,coordinate.longitude];
    
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req addValue:zomatokey forHTTPHeaderField:@"user-key"];
    [req setHTTPBody:PostData];
    
    NSData *data = [NSURLConnection  sendSynchronousRequest:req returningResponse:NULL error:NULL];
    //    NSString *myString = [[NSString alloc] initWithData:res encoding:NSUTF8StringEncoding];
    //    NSLog(@"%@", myString);
    
    NSDictionary *restaurantsData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *searchResults =[restaurantsData objectForKey:@"restaurants"];
    NSLog(@"%lu",(unsigned long)searchResults.count);
    
    return searchResults;
}

- (NSDictionary *) restaurantDetails: (NSString *) restaurantID{
    // restaurant details
    NSString *Post = [[NSString alloc] initWithFormat:@"{Page:0, Take:10}"];
    NSData *PostData = [Post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *zomatokey=@"b911890e669706c34d302c47f3709db6";
    
    NSString *strUrl=[NSString stringWithFormat:@"https://developers.zomato.com/api/v2.1/restaurant?res_id=%@",restaurantID];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req addValue:zomatokey forHTTPHeaderField:@"user-key"];
    [req setHTTPBody:PostData];
    
    NSData *data = [NSURLConnection  sendSynchronousRequest:req returningResponse:NULL error:NULL];
    
    NSDictionary *restaurantDetails = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    return restaurantDetails;
}

-(CLLocationCoordinate2D ) getLocationFromAddressString: (NSString*) addressStr {
    
    __block BOOL isRunLoopNested = NO;
    __block BOOL isOperationCompleted = NO;
    coder=[[CLGeocoder alloc]init];
    __block CLLocationCoordinate2D coordinate;
    
    [coder geocodeAddressString:addressStr completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if(!error)
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             coordinate.latitude=placemark.location.coordinate.latitude;
             coordinate.longitude=placemark.location.coordinate.longitude;
         }
         else
         {
             NSLog(@"There was a forward geocoding error\n%@",[error localizedDescription]);
         }
         isOperationCompleted = YES;
         if (isRunLoopNested) {
             CFRunLoopStop(CFRunLoopGetCurrent()); // CFRunLoopRun() returns
         }
     }];
    if ( ! isOperationCompleted) {
        isRunLoopNested = YES;
        NSLog(@"Waiting...");
        CFRunLoopRun(); // Magic!
        isRunLoopNested = NO;
    }
    
    return coordinate;
}
@end
