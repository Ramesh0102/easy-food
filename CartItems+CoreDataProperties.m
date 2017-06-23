//
//  CartItems+CoreDataProperties.m
//  easy-food
//
//  Created by remotertiger_user on 6/22/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "CartItems+CoreDataProperties.h"

@implementation CartItems (CoreDataProperties)

+ (NSFetchRequest<CartItems *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CartItems"];
}

@dynamic itemname;
@dynamic itemprice;

@end
