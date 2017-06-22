//
//  CartItems+CoreDataProperties.h
//  easy-food
//
//  Created by remotertiger_user on 6/22/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "CartItems+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CartItems (CoreDataProperties)

+ (NSFetchRequest<CartItems *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *itemname;
@property (nullable, nonatomic, copy) NSString *itemprice;

@end

NS_ASSUME_NONNULL_END
