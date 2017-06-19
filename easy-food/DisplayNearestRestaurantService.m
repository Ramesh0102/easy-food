//
//  DisplayNearestRestaurantService.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//


#import "DisplayNearestRestaurantService.h"
@interface DisplayNearestRestaurantService(){
    
    NSMutableDictionary *currentUserAddress;
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

- (NSString *) checkEneteredEmail:(NSString *) inEmail andPassword:(NSString *) inPwd{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    NSManagedObjectContext *context=coreDataStack.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"RegisteredCustomers" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"email == %@ AND password == %@", inEmail, inPwd];
    [fetchRequest setPredicate:predicate];
    
    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    
    if (result.count > 0 ){
        return @"success";
    }
    return @"nil";
}

- (void) getCurrentUserAddressForEmail:(NSString *) email{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    NSManagedObjectContext *context=coreDataStack.persistentContainer.viewContext;
//    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
//    NSEntityDescription *entity=[NSEntityDescription entityForName:@"RegisteredCustomers" inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"RegisteredCustomers"];
    request.predicate = [NSPredicate predicateWithFormat:@"email == %@", email];
    //request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]];
    
    NSArray *results = [context executeFetchRequest:request error:nil];
    
    NSError *error=nil;
    NSArray *result=[context executeFetchRequest:fetchRequest error:&error];
    currentUserAddress=[[NSMutableDictionary alloc]init];
    
    
    
}

- (void) getRestaurantDetails:(NSString *) email{
    
}

@end
