//
//  AppDelegate.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "AppDelegate.h"
#import "DisplayNearestRestaurantsViewController.h"

@interface AppDelegate (){
    
    NSDictionary *currentUserDetails;
    NSString * email;
    NSString *password;

}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    email = [[NSUserDefaults standardUserDefaults] valueForKey:@"currentUserEmail"];
    
    BOOL status = [[NSUserDefaults standardUserDefaults] boolForKey:@"userStatus"];
    
    
    if (status) {
        //go straight to my home-screen-activity
        [self gotoHome];
    }

    //[self gotoHome];
    
    return YES;
}

-(void) gotoHome{
    //goto home
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    
    DisplayNearestRestaurantsViewController * vcD = [storyboard instantiateViewControllerWithIdentifier:@"nrRest"];
    vcD.email = email;
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    //[self saveContext];
}



@end
