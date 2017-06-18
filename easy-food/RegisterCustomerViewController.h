//
//  RegisterCustomerViewController.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayNearestRestaurantPresenter.h"
#import "DisplayNearestRestaurantService.h"

@interface RegisterCustomerViewController : UIViewController <DisplayNearestRestaurantPresenterDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fullName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *rePassword;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *zipcode;
@property (weak, nonatomic) IBOutlet UITextField *mobile;

- (IBAction)registerCustomerWithEnteredDetails;


@end
