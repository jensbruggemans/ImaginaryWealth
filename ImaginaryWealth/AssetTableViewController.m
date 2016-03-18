//
//  AssetTableViewController.m
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 14/03/16.
//  Copyright © 2016 jens. All rights reserved.
//

#import "AssetTableViewController.h"

#import "AssetManager.h"
#import "Asset.h"
#import "AddAssetViewController.h"
#import "AssetDetailTableViewController.h"

@interface AssetTableViewController () <AddAssetViewControllerDelegate>

@property AssetManager * assetManager;

@end

@implementation AssetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.assetManager = [AssetManager sharedManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.assetManager.assets.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssetCell" forIndexPath:indexPath];
    
    Asset * asset = self.assetManager.assets[indexPath.row];
    
    cell.textLabel.text = asset.name;
    
    cell.detailTextLabel.text = asset.initialValue.stringValue;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self.assetManager deleteAssetAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    [self.assetManager moveAssetAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
    
    NSLog(@"Replacing asset %li with asset %li.", (long)fromIndexPath.row, (long)toIndexPath.row);
}


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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // '==' compares memory addresses, so we use isEqualToString:
    if ([segue.identifier isEqualToString: @"addAssetSegue"]) {
        
        UINavigationController * navigationController = segue.destinationViewController;
        
        AddAssetViewController * addAssetViewController = navigationController.viewControllers[0];
        
        addAssetViewController.delegate = self;
    }
    
    
    else if ([segue.identifier isEqualToString: @"ShowDetail"]) {
        
        AssetDetailTableViewController * detailController = segue.destinationViewController;
        
        detailController.asset = self.assetManager.assets[self.tableView.indexPathForSelectedRow.row];
    }
}

- (IBAction)rightAddButtonPressed:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add an asset"
                                                                   message:@"Enter the name and value of the asset you want to add."
                                                            preferredStyle:UIAlertControllerStyleAlert]; // 1
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
        textfield.placeholder = @"name";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
        textfield.placeholder = @"value";
    }];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Add"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              NSString * name = alertController.textFields[0].text;
                                                              NSString * valueAsString = alertController.textFields[1].text;
                                                              
                                                              NSDecimalNumber * value = [NSDecimalNumber decimalNumberWithString:valueAsString];
                                                              
                                                              [self.assetManager addAssetWithName:name andInitialValue:value];
                                                              
                                                              [self.tableView reloadData];
                                                          }]; // 2
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           }]; // 3
    
    [alertController addAction:firstAction]; // 4
    [alertController addAction:secondAction]; // 5
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void) addAssetViewControllerSaveClicked:(AddAssetViewController *)viewController {
    NSLog(@"Save clicked");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString * name = viewController.name;
    NSDecimalNumber * value = viewController.initialValue;
    
    [self.assetManager addAssetWithName:name andInitialValue:value];
    [self.tableView reloadData];
}

- (void) addAssetViewControllerCancelClicked:(AddAssetViewController *)viewController {
    NSLog(@"Cancel clicked");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end










