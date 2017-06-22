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
}

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"Cart";
    NSString *name=[_itemDict objectForKey:@"name"];
    NSString *price=[_itemDict objectForKey:@"price"];
    
    [self saveItem:name price:price];
    [self getCartItems];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cartcell"];
    
    cell.textLabel.text=[cartItemNames objectAtIndex:indexPath.row];
    
    cell.detailTextLabel.text=[cartItemPrice objectAtIndex:indexPath.row];
    _total.text=[NSString stringWithFormat:@"%@",[_itemDict valueForKey:@"price"]];
    //cell.imageView.image=_image;
    //cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) saveItem: (NSString *)itemname price:(NSString *) price{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    
    CartItems *item=[NSEntityDescription insertNewObjectForEntityForName:@"CartItems" inManagedObjectContext:coreDataStack.persistentContainer.viewContext];
    item.itemname=itemname;
    item.itemprice=price;
    
    [coreDataStack saveContext];
}
- (void) getCartItems{
    
    CoreDataClass *coreDataStack=[CoreDataClass getCoreDataStack];
    
    cartItemNames=[[NSMutableArray alloc]init];
    cartItemPrice=[[NSMutableArray alloc]init];
    NSManagedObjectContext *context=coreDataStack.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc]init];
    fetchRequest.entity=[NSEntityDescription entityForName:@"CartItems" inManagedObjectContext:context];
    
    NSArray *allItems=[context executeFetchRequest:fetchRequest error:nil];
    for (int i=0; i<allItems.count; i++) {
        [cartItemNames addObject:[NSString stringWithFormat:@"%@",[[allItems objectAtIndex:i] valueForKey:@"itemname"]]];
        
        [cartItemPrice addObject:[NSString stringWithFormat:@"%@",[[allItems objectAtIndex:i] valueForKey:@"itemname"]]];
    }
}



@end
