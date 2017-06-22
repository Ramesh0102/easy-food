//
//  RestaurantMenuViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/21/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "RestaurantMenuViewController.h"

@interface RestaurantMenuViewController (){
    NSDictionary *restaurantsMenu;
    NSMutableArray *menu;
    NSIndexPath *selectedIndex;
}

@end

@implementation RestaurantMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageView.image=_image;
    NSLog(@"%@",[_individualRestaurantDetails valueForKey:@"name"]);
    self.navigationItem.title=[_individualRestaurantDetails valueForKey:@"name"];
    _restNameAndCity.text=[_individualRestaurantDetails valueForKey:@"name"];
    _timings.text=[[_individualRestaurantDetails objectForKey:@"location"] valueForKey:@"address"];
    _discription.text=[NSString stringWithFormat:@"cuisines : %@",[_individualRestaurantDetails valueForKey:@"cuisines"]];
    
    restaurantsMenu=[[NSDictionary alloc]init];
    menu=[[NSMutableArray alloc]init];
    [self getRestaurantMenu:[[_individualRestaurantDetails objectForKey:@"R"] valueForKey:@"res_id"]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"reusableCell"];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[[menu objectAtIndex:indexPath.row] valueForKey:@"name"]];
    
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[[menu objectAtIndex:indexPath.row] valueForKey:@"price"]];
    //cell.imageView.image=_image;
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndex=indexPath;
    //NSLog(@"index Path : %@",indexPath);
    //[self performSegueWithIdentifier:@"cartSegue" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"cartSegue"]){
        CartViewController* detailsController = (CartViewController*)[segue destinationViewController];
        detailsController.itemDict=[menu objectAtIndex:selectedIndex.row];
    }
}

- (void) getRestaurantMenu: (NSString*)rest_id{
    
    NSString *Post = [[NSString alloc] initWithFormat:@"{Page:0, Take:10}"];
    NSData *PostData = [Post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *zomatokey=@"b911890e669706c34d302c47f3709db6";
    
    NSString *temp_rest_id=@"16507624"; //try this to see menu
    NSString *strUrl=[NSString stringWithFormat:@"https://developers.zomato.com/api/v2.1/dailymenu?res_id=%@",temp_rest_id];
    
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    [req setHTTPMethod:@"POST"];
    [req addValue:zomatokey forHTTPHeaderField:@"user-key"];
    [req setHTTPBody:PostData];
    
    NSData *data = [NSURLConnection  sendSynchronousRequest:req returningResponse:NULL error:NULL];
    
    restaurantsMenu = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    //NSLog(@"%lu",(unsigned long)restaurantsMenu.count);
    //NSLog(@"%@",[restaurantsMenu allKeys]);
    
    
    NSArray *daily_menus=[restaurantsMenu objectForKey:@"daily_menus"];
    
    for (int i=0; i<daily_menus.count; i++) {
        NSDictionary *first_daily_menu=[daily_menus objectAtIndex:i];
        //NSLog(@"%@",[first_daily_menu allKeys]);
        
        NSArray *dishes=[[first_daily_menu objectForKey:@"daily_menu"] objectForKey:@"dishes"];
        //NSLog(@"%lu",(unsigned long)dishes.count);
        for (int j=0;j<dishes.count; j++) {
            NSDictionary *dish=[dishes objectAtIndex:j];
            //NSLog(@"%@",[dish allKeys]);
            [menu addObject:[dish objectForKey:@"dish"]];
        }
    }
    //NSLog(@"\n menu:%lu ",(unsigned long)menu.count);
}
@end
