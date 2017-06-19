//
//  DisplayNearestRestaurantService.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//


#import "DisplayNearestRestaurantService.h"
@interface DisplayNearestRestaurantService(){

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
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"RegisteredCustomers" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"email == %@ AND password == %@", email, password];
    [fetchRequest setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    NSManagedObject *managedObject=result[0];
    NSArray *keys = [[[managedObject entity] attributesByName] allKeys];
    NSDictionary *dict = [managedObject dictionaryWithValuesForKeys:keys];
    if (result.count > 0 ){
        handler(YES,dict);
    }else{
        handler(NO,nil);
    }
}

- (void) getRestaurantDetails:(NSString *) email{
    
}

@end
