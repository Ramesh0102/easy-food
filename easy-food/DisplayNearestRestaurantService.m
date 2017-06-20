//
//  DisplayNearestRestaurantService.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//


#import "DisplayNearestRestaurantService.h"
@interface DisplayNearestRestaurantService(){
    
    NSDictionary *restaurantDictionary;

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
    
    NSManagedObject *managedObject=result[0];
    NSArray *keys = [[[managedObject entity] attributesByName] allKeys];
    NSDictionary *dict = [managedObject dictionaryWithValuesForKeys:keys];
    if (result.count > 0 ){
        handler(YES,dict);
    }else{
        handler(NO,nil);
    }
}

- (NSDictionary *) getRestaurantDetails:(NSString *) address{
    
    __block int latitude;
    __block int longitude;
    
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSLog(@"%@",placemark);
        CLLocation *location = placemark.location;
        CLLocationCoordinate2D coordinate = location.coordinate;
       // NSLog(@"Latitude %f", coordinate.latitude);
       // NSLog(@"Longitude %f", coordinate.longitude);
        latitude=coordinate.latitude;
        longitude=coordinate.longitude;
    }];
    
   // NSString *strURL=[NSString stringWithFormat:@"https:query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20local.search%%20where%%20zip%%3D%%27%@%%27%%20and%%20query%%3D%%27%@%%27&format=json&callback=",where,what];
//    
//    NSURL *url=[NSURL URLWithString:strURL];
//    
//    NSData *data=[NSData dataWithContentsOfURL:url];
//    NSString *strData=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *dictionary=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    coordinates=[[[dictionary objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"result"];
    return restaurantDictionary;
}

@end
