//
//  StuffTableViewController.m
//  easy-food
//
//  Created by Trainee_user on 6/23/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "StuffTableViewController.h"
#import "DetailsViewController.h"
#import "MapViewController.h"

@interface StuffTableViewController (){
    
    NSArray *allResults;
    
}

@end

@implementation StuffTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.stuff;
    
    NSString *str  = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20local.search%%20where%%20zip%%3D'%@'%%20and%%20query%%3D'%@'&format=json&diagnostics=true&callback=",self.zipcode,self.stuff];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:str]];
    
    
    NSDictionary *dataFromWeb = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    allResults = [[[dataFromWeb objectForKey:@"query"] objectForKey:@"results"] objectForKey:@"Result"];
    
    //allResults = [dataFromWeb objectForKey:@"users"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//
//    return allResults.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return allResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[allResults objectAtIndex:indexPath.row] objectForKey:@"Title"];
    
    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"details"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailsViewController *dvc = segue.destinationViewController;
        dvc.currentStuff = [allResults objectAtIndex:indexPath.row];
    } else {
        
        MapViewController *mapVC = segue.destinationViewController;
        mapVC.allPoints = allResults;
        
        
    }
    
    
}


@end
