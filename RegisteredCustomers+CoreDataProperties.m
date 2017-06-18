//
//  RegisteredCustomers+CoreDataProperties.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "RegisteredCustomers+CoreDataProperties.h"

@implementation RegisteredCustomers (CoreDataProperties)

+ (NSFetchRequest<RegisteredCustomers *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RegisteredCustomers"];
}

@dynamic address;
@dynamic city;
@dynamic country;
@dynamic email;
@dynamic fullname;
@dynamic mobile;
@dynamic password;
@dynamic satate;
@dynamic zipcode;

@end
