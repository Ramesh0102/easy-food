//
//  RegisterCustomerViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "RegisterCustomerViewController.h"
#import "DisplayNearestRestaurantsViewController.h"

@interface RegisterCustomerViewController (){
    DisplayNearestRestaurantService *service;
    DisplayNearestRestaurantPresenter *presenter;
    NSMutableDictionary *newCustomerDeatils;
}

@end

@implementation RegisterCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    service=[[DisplayNearestRestaurantService alloc]init];
    presenter=[[DisplayNearestRestaurantPresenter alloc] initWithService:service];
    presenter.delegate=self;
    self.navigationItem.title=[NSString stringWithFormat:@"Create Account "];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"2.jpg"]]];
    self.view.alpha=0.8;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) registerCustomerWithEnteredDetails {
    
//    if ([_fullName.text isEqual:@""] && [_email.text isEqual:@""] && [_password.text isEqual:@""] && [_address.text isEqual:@""] && [_zipcode.text isEqual:@""] && [_mobile.text isEqual:@""]) {
//        [self displayAlert];
//    }else{
    
    newCustomerDeatils=[[NSMutableDictionary alloc]init];
    newCustomerDeatils[@"fullname"] = self.fullName.text;
    newCustomerDeatils[@"email"] = self.email.text;
    newCustomerDeatils[@"password"] = self.password.text;
    newCustomerDeatils[@"address"] = self.address.text;
    newCustomerDeatils[@"zipcode"] = self.zipcode.text;
    newCustomerDeatils[@"mobile"] = self.mobile.text;
    
    [presenter registerNewCustomer:newCustomerDeatils];
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    
    DisplayNearestRestaurantsViewController * vcD = [storyboard instantiateViewControllerWithIdentifier:@"nrRest"];
    vcD.email = self.email.text;

    
//    
       [[NSUserDefaults standardUserDefaults] setValue:self.email.text forKey:@"currentUserEmail"];
    [[NSUserDefaults standardUserDefaults] setValue:_address.text forKey:@"currentUserAddress"];
    [[NSUserDefaults standardUserDefaults] setValue:_zipcode.text forKey:@"currentUserZipcode"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userStatus"];
//        
       [[NSUserDefaults standardUserDefaults] synchronize];
//        
//    }
}

- (void) displayAlert{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error!" message:@"please regiter with us or enter correct details!." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
