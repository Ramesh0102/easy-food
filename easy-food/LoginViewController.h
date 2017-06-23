//
//  LoginViewController.h
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisplayNearestRestaurantPresenter.h"
#import "DisplayNearestRestaurantService.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inEmail;
@property (weak, nonatomic) IBOutlet UITextField *inPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)forgotPassword:(id)sender;
-(void) gotoHome;
- (void) doisplayAlert;

@end
