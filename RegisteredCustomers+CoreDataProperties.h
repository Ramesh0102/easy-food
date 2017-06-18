//
//  RegisteredCustomers+CoreDataProperties.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "RegisteredCustomers+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RegisteredCustomers (CoreDataProperties)

+ (NSFetchRequest<RegisteredCustomers *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSString *country;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *fullname;
@property (nonatomic) int64_t mobile;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *satate;
@property (nullable, nonatomic, copy) NSString *zipcode;

@end

NS_ASSUME_NONNULL_END
