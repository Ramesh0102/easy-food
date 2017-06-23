//
//  CartViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/22/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "CartViewController.h"


@interface CartViewController (){
    
    NSMutableArray *cartItemNames;
    NSMutableArray *cartItemPrice;
    NSString *name;
    NSString *price;
    NSMutableArray *allItems;
}

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"Cart";
    name=[_itemDict objectForKey:@"name"];
    price=[_itemDict objectForKey:@"price"];
    
    //if (_itemDict!=nil) {
        [self saveItem:name price:price];
    //}
    [self getCartItems];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1.jpg"]]];
//    self.view.alpha=0.8;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return cartItemNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cartcell"];
    
    cell.textLabel.text=[cartItemNames objectAtIndex:indexPath.row];
    cell.detailTextLabel.text=[cartItemPrice objectAtIndex:indexPath.row];
    _total.text=price;
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
        NSManagedObjectContext *context=coreDataStack.persistentContainer.viewContext;
        [context deleteObject:[allItems objectAtIndex:indexPath.row]];
        NSError *error=nil;
        if (![context save:&error]) {
            NSLog(@"Can't delete! %@, %@",error, [error localizedDescription]);
            return;
        }
        
        [cartItemNames removeObjectAtIndex:indexPath.row];
        [cartItemPrice removeObjectAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        // [self.tableView reloadData];
    }
}

- (void) saveItem: (NSString *)itemname price:(NSString *) itemprice{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    
    CartItems *item=[NSEntityDescription insertNewObjectForEntityForName:@"CartItems" inManagedObjectContext:coreDataStack.persistentContainer.viewContext];
    item.itemname=itemname;
    item.itemprice=itemprice;
    
    [coreDataStack saveContext];
}
- (void) getCartItems{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    
    cartItemNames=[[NSMutableArray alloc]init];
    cartItemPrice=[[NSMutableArray alloc]init];
    NSManagedObjectContext *context=coreDataStack.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    fetchRequest.entity=[NSEntityDescription entityForName:@"CartItems" inManagedObjectContext:context];
    
    allItems=[[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    for (int i=0; i<allItems.count; i++) {
        [cartItemNames addObject:[NSString stringWithFormat:@"%@",[[allItems objectAtIndex:i] valueForKey:@"itemname"]]];
        
        [cartItemPrice addObject:[NSString stringWithFormat:@"%@",[[allItems objectAtIndex:i] valueForKey:@"itemprice"]]];
    }
}



@end
