//
//  LoginViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController (){
    DisplayNearestRestaurantPresenter *presenter;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _inEmail.returnKeyType = UIReturnKeyNext;
    _inPassword.returnKeyType = UIReturnKeyNext;
    presenter=[[DisplayNearestRestaurantPresenter alloc]init];
    
    NSLog(@"login +++ ");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [presenter checkEmail:_inEmail andPassword:_inPassword completion:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"Not working");
        } else {
            NSLog(@"Working!");
        }
    }];
    
    return YES;
}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)registerNewCustomer:(id)sender {
}
@end
