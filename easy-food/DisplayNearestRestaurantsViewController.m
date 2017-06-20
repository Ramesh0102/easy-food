//
//  DisplayNearestRestaurantsViewController.m
//  easy-food
//
//  Created by remotertiger_user on 6/17/17.
//  Copyright © 2017 remotetiger.com. All rights reserved.
//

#import "DisplayNearestRestaurantsViewController.h"

@interface DisplayNearestRestaurantsViewController (){
    
    NSDictionary *restaurantsDictionary;
    NSDictionary *currentUserDetails;
}

@end

@implementation DisplayNearestRestaurantsViewController

//static NSString * const reuseIdentifier = @"reusableCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    _service=[[DisplayNearestRestaurantService alloc]init];
    _presenter=[[DisplayNearestRestaurantPresenter alloc]initWithService:_service];

    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    NSData *dictionaryData = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserDictionary"];
    currentUserDetails = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    
    self.navigationItem.title=[NSString stringWithFormat:@"%@",[[NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData] objectForKey:@"address"]];
    
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
    return 1;//restaurantsDictionary.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    // Configure the cell
    //[_presenter getRestaurantDetails:[NSString stringWithFormat:@"%@",[currentUserDetails valueForKey:@"zipcode"]]];
    
    CustomCollectionViewCellForHome  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reusableCell" forIndexPath:indexPath];
    
    NSString *address=[NSString stringWithFormat:@"%@, %@, %@", [currentUserDetails objectForKey:@"address"], [currentUserDetails objectForKey:@"city"], [currentUserDetails objectForKey:@"zipcode"]];
    [_presenter getRestaurantDetails:address completion:^(NSDictionary *restaurants){
        
        restaurantsDictionary=restaurants;
        
        
    }];
    
    cell.imageView.image=[UIImage imageNamed:@"home_icon.png"];
    cell.label.text=@"....";

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 150);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

- (void)logoutClicked:(id)sender {
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
