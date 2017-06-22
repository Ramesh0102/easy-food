//
//  RestaurantMenuViewController.h
//  easy-food
//
//  Created by remotertiger_user on 6/21/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"
@interface RestaurantMenuViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
    
@property (strong, nonatomic) NSDictionary *individualRestaurantDetails;
@property (weak, nonatomic) IBOutlet UILabel *restNameAndCity;
@property (weak, nonatomic) IBOutlet UILabel *discription;
@property (weak, nonatomic) IBOutlet UILabel *timings;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIImage *image;

@end
