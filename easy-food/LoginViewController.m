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
    DisplayNearestRestaurantService *service;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    service=[[DisplayNearestRestaurantService alloc]init];
    presenter=[[DisplayNearestRestaurantPresenter alloc]initWithService:service];
    _inEmail.delegate = self;
    _inPassword.delegate=self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    if(textField.returnKeyType==UIReturnKeyNext) {
        [_inPassword becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone) {
        [_inPassword resignFirstResponder];
        [presenter checkEmail:_inEmail.text andPassword:_inPassword.text completion:^(BOOL succeeded) {
            if (succeeded==YES) {
                //goto home
                [self presentViewController:_tabbarController animated:YES completion:nil];
                NSLog(@"Not working");
            } else {
                //display error
                UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error!" message:@"please regiter with us." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
    return YES;
}

- (IBAction)forgotPassword:(id)sender {
}

- (IBAction)registerNewCustomer:(id)sender {
}
@end
