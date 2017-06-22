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
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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
        NSLog(@"%lu",(unsigned long)restaurantsArray.count);
    }];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    }

- (void) loadView{
    [super loadView];
 
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return restaurantsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    // Configure the cell
    //[_presenter getRestaurantDetails:[NSString stringWithFormat:@"%@",[currentUserDetails valueForKey:@"zipcode"]]];
    
    CustomCollectionViewCellForHome  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reusableCell" forIndexPath:indexPath];
    
    UIImage *image=[self getThumbUrlForRow:indexPath.row];
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


#pragma mark <UICollectionViewDelegate>

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"touch me...");
//    selectedIndexPath=indexPath;
//    [self performSegueWithIdentifier:@"restaurantMenu" sender:self];
//}
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath=indexPath;
    NSLog(@"%ld",(long)selectedIndexPath.row);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"restaurantMenu"]) {
        NSLog(@"%ld",(long)selectedIndexPath.row);
        RestaurantMenuViewController *destinationVC=(RestaurantMenuViewController*)[segue destinationViewController];
        destinationVC.individualRestaurantDetails=[individualRestaurantDetails objectAtIndex:selectedIndexPath.row];;
        destinationVC.image=[imagesList objectAtIndex:selectedIndexPath.row];
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

- (UIImage *) getThumbUrlForRow: (long) row{
    
    __block BOOL isRunLoopNested = NO;
    __block BOOL isOperationCompleted = NO;
    __block UIImage *image;
    
    NSString *restId=[NSString stringWithFormat:@"%@",[[[[restaurantsArray objectAtIndex:row] objectForKey:@"restaurant"] objectForKey:@"R"] objectForKey:@"res_id"]];
    [_presenter restaurantDetails:restId completion:^(NSDictionary *restaurant) {
        [individualRestaurantDetails addObject:restaurant];
        NSString *strUrl=[restaurant valueForKey:@"featured_image"];
        if ([strUrl isEqual:@""]) {
            strUrl=[restaurant valueForKey:@"thumb"];
        }
        image=[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]]];
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
    if (image==nil) {
        image=[UIImage imageNamed:@"1.jpg"];
    }
    return image;
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
