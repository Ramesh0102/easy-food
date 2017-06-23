//
//  CartViewController.h
//  easy-food
//
//  Created by remotertiger_user on 6/22/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataClass.h"
#import "CartItems+CoreDataClass.h"

@interface CartViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *itemDict;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void) saveItem: (NSString *)itemname price:(NSString *) price;
- (void) getCartItems;

@end
