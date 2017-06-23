//
//  DisplayNearestRestaurantsViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "DisplayNearestRestaurantsViewController.h"

@interface DisplayNearestRestaurantsViewController (){
    
    NSArray *restaurantsArray;
    NSDictionary *currentUserDetails;
    NSString *completeAddress;
    NSMutableArray *individualRestaurantDetails;
    NSMutableArray *imagesList;
    NSIndexPath *selectedIndexPath;
}

@end

@implementation DisplayNearestRestaurantsViewController

//static NSString * const reuseIdentifier = @"reusableCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    _service=[[DisplayNearestRestaurantService alloc]init];
    _presenter=[[DisplayNearestRestaurantPresenter alloc]initWithService:_service];
    
    _coder = [[CLGeocoder alloc] init];
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserDictionary"];
    currentUserDetails = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    self.navigationItem.title=[NSString stringWithFormat:@"%@",[[NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData] objectForKey:@"address"]];
    
    NSString *address=[NSString stringWithFormat:@"%@", [currentUserDetails objectForKey:@"address"]];
    NSString *zipcode=[NSString stringWithFormat:@"%@",[currentUserDetails objectForKey:@"zipcode"]];
    
    individualRestaurantDetails=[[NSMutableArray alloc] init];
    imagesList=[[NSMutableArray alloc]init];
    
    [self didEnterZip:zipcode address:address];
    [_presenter searchReastaurants:completeAddress completion:^(NSArray *restaurants) {
        restaurantsArray=[NSArray arrayWithArray:restaurants];
        //NSLog(@"%lu",(unsigned long)restaurantsArray.count);
    }];
    
    for (int i=0; i<restaurantsArray.count; i++) {
        [self downloadIndividualRestaurantDetails:i];
    }

}


- (void) loadView{
    [super loadView];
 
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return restaurantsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    // Configure the cell
    //[_presenter getRestaurantDetails:[NSString stringWithFormat:@"%@",[currentUserDetails valueForKey:@"zipcode"]]];
    
    CustomCollectionViewCellForHome  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reusableCell" forIndexPath:indexPath];
    
    NSString *strUrl=[[individualRestaurantDetails objectAtIndex:indexPath.row] valueForKey:@"featured_image"];
    UIImage* image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]]];
    if (image==nil) {
        image=[UIImage imageNamed:@"1.jpg"];
    }
    [imagesList addObject:image];
    cell.imageView.image=image;
    cell.label.text=[NSString stringWithFormat:@"%@,\n %@",[[[restaurantsArray objectAtIndex:indexPath.row] objectForKey:@"restaurant"] objectForKey:@"name"],[[[individualRestaurantDetails objectAtIndex:indexPath.row] objectForKey:@"location"] valueForKey:@"address"]];

    return cell;
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //int numberOfCellInRow = 3;
//    CGFloat cellWidth =  [[UIScreen mainScreen] bounds].size.width-40;
//    return CGSizeMake(cellWidth, cellWidth-50);
//}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath * indexPath = [[self.colectionView indexPathsForSelectedItems] objectAtIndex:0];
    
    if ([segue.destinationViewController isKindOfClass:[RestaurantMenuViewController class]]) {
        NSLog(@"%ld",(long)indexPath.row);
        
        RestaurantMenuViewController *destinationVC=(RestaurantMenuViewController*)[segue destinationViewController];
        destinationVC.individualRestaurantDetails=[individualRestaurantDetails objectAtIndex:indexPath.row];;
        destinationVC.image=[imagesList objectAtIndex:indexPath.row];
    }
}

- (void) didEnterZip:(NSString*)zip address:(NSString*)address {
    
    __block BOOL isRunLoopNested = NO;
    __block BOOL isOperationCompleted = NO;
    
    [self.coder geocodeAddressString:zip completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (!error) {
            CLPlacemark *place=[placemarks objectAtIndex:0];
            //NSLog(@"%@", place);
            completeAddress=[NSString stringWithFormat:@"%@, %@, %@, %@ %@", address, place.locality,place.administrativeArea,place.ISOcountryCode, zip];
            //completeAddress=[NSString stringWithFormat:@"%@", zip];
            
        }else{
            NSLog(@"Error!");
        }
        isOperationCompleted = YES;
        if (isRunLoopNested) {
            CFRunLoopStop(CFRunLoopGetCurrent()); // CFRunLoopRun() returns
        }
    }];
    if ( ! isOperationCompleted) {
        isRunLoopNested = YES;
        NSLog(@"Waiting...");
        CFRunLoopRun(); // Magic!
        isRunLoopNested = NO;
    }
}

- (void) downloadIndividualRestaurantDetails: (long) row{
    
    __block BOOL isRunLoopNested = NO;
    __block BOOL isOperationCompleted = NO;
    
    NSString *restId=[NSString stringWithFormat:@"%@",[[[[restaurantsArray objectAtIndex:row] objectForKey:@"restaurant"] objectForKey:@"R"] objectForKey:@"res_id"]];
    [_presenter restaurantDetails:restId completion:^(NSDictionary *restaurant) {
        [individualRestaurantDetails addObject:restaurant];
        isOperationCompleted = YES;
        if (isRunLoopNested) {
            CFRunLoopStop(CFRunLoopGetCurrent()); // CFRunLoopRun() returns
        }
    }];
    if ( ! isOperationCompleted) {
        isRunLoopNested = YES;
        NSLog(@"Waiting...");
        CFRunLoopRun(); // Magic!
        isRunLoopNested = NO;
    }
}

- (void)logoutClicked:(id)sender {
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
