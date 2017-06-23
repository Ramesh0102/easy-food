//
//  LoginViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "LoginViewController.h"
#import "DisplayNearestRestaurantsViewController.h"

@interface LoginViewController (){
    DisplayNearestRestaurantPresenter *presenter;
    DisplayNearestRestaurantService *service;
    NSDictionary *currentUserDetails;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    }
- (void) loadView{
    [super loadView];
    service=[[DisplayNearestRestaurantService alloc]init];
    presenter=[[DisplayNearestRestaurantPresenter alloc]initWithService:service];
    _inEmail.delegate = self;
    _inPassword.delegate=self;
    
    self.navigationItem.title=@"Sign in";
    self.imageView.image=[UIImage imageNamed:[NSString stringWithFormat:@"eat_sleep_code_1.png"]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]]];
    self.view.alpha=0.8;
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    //NSString *str=@"";
    if(textField.returnKeyType==UIReturnKeyNext) {
        [_inPassword becomeFirstResponder];
    } else if (textField.returnKeyType==UIReturnKeyDone && ![_inEmail.text isEqual:@""] && ![_inPassword.text isEqual:@""]) {
        [_inPassword resignFirstResponder];
        [presenter checkEmail:_inEmail.text andPassword:_inPassword.text completion:^(BOOL succeeded, NSDictionary *userDctionary){
            
            if (succeeded) {
                
                //NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userDctionary];
                
                
                [[NSUserDefaults standardUserDefaults] setValue:_inEmail.text forKey:@"currentUserEmail"];
                [[NSUserDefaults standardUserDefaults] setValue:[userDctionary valueForKey:@"address"] forKey:@"currentUserAddress"];
                [[NSUserDefaults standardUserDefaults] setValue:[userDctionary valueForKey:@"zipcode"] forKey:@"currentUserZipcode"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"userStatus"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];

                //goto home
                [self gotoHome];
            }else{
                [self doisplayAlert];
            }
        }];
    }
    else {
        [self doisplayAlert];
        
    }
    return YES;
}
- (void) doisplayAlert{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Error!" message:@"please regiter with us or enter correct details!." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void) gotoHome{
    //goto home
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    
    DisplayNearestRestaurantsViewController * vcD = [storyboard instantiateViewControllerWithIdentifier:@"nrRest"];
    vcD.email = _inEmail.text;
    vcD.password = _inPassword.text;

    
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)forgotPassword:(id)sender {
}

@end
