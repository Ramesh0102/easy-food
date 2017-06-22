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
    
    //NSDictionary * myDictionary = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"dictionaryKey"];
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserDictionary"];
    currentUserDetails = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    if ([currentUserDetails valueForKey:@"email"]) {
        //go straight to my home-screen-activity
        [self gotoHome];
    }

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
        [presenter checkEmail:_inEmail.text andPassword:_inPassword.text completion:^(BOOL succeeded, NSDictionary *userDctionary){
            
            if (succeeded) {
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userDctionary];
                [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"currentUserDictionary"];
                
                [[NSUserDefaults standardUserDefaults] synchronize];

                //goto home
                [self gotoHome];
        
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


-(void) gotoHome{
    //goto home
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)forgotPassword:(id)sender {
}

@end
