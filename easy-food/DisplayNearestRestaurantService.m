//
//  DisplayNearestRestaurantService.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "DisplayNearestRestaurantService.h"

@implementation DisplayNearestRestaurantService


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

- (NSString *) giveMePasswordIfEmailExist:(NSString *) email{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    NSManagedObjectContext *context=coreDataStack.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"RegisteredCustomers" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF contains[c] %@",email];
    [fetchRequest setPredicate:predicate];
    
    NSError *error=nil;
    NSMutableArray *fetchedObjects=[[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (fetchedObjects==nil) {
        return @"Not Registered";
    }else{
        return fetchedObjects[0];
    }
    return @"nil";
}

@end
