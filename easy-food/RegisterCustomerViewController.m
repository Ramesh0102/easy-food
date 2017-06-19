//
//  RegisterCustomerViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "RegisterCustomerViewController.h"

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
    
    newCustomerDeatils=[[NSMutableDictionary alloc]init];
    newCustomerDeatils[@"fullname"] = self.fullName.text;
    newCustomerDeatils[@"email"] = self.email.text;
    newCustomerDeatils[@"password"] = self.password.text;
    newCustomerDeatils[@"rePassword"] = self.rePassword.text;
    newCustomerDeatils[@"address"] = self.address.text;
    newCustomerDeatils[@"city"] = self.city.text;
    newCustomerDeatils[@"zipcode"] = self.zipcode.text;
    newCustomerDeatils[@"mobile"] = self.mobile.text;
    
    [presenter registerNewCustomer:newCustomerDeatils];
    NSDictionary *customerDetails=newCustomerDeatils;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:customerDetails];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentUserDictionary"];
}
@end
