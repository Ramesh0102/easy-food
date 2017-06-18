//
//  CoreDataClass.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataClass : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
+(CoreDataClass *) getCoreDataStack;


@end
