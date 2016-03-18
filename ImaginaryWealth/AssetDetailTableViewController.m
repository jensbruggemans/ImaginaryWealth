//
//  AssetDetailTableViewController.m
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 16/03/16.
//  Copyright © 2016 jens. All rights reserved.
//

#import "AssetDetailTableViewController.h"

#import "Transaction.h"

#import "AssetManager.h"

@interface AssetDetailTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation AssetDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = self.asset.name;
    [self updateValueLabel];
}

- (void) updateValueLabel {
    NSDecimalNumber * total = self.asset.initialValue;

    /*
    for (Transaction * transaction in self.asset.transactions) {
        total = [total decimalNumberByAdding:transaction.amount];
    }*/
    
    for (int i = 0; i < self.asset.transactions.count; i++) {
        Transaction * transaction = self.asset.transactions[i];
        total = [total decimalNumberByAdding:transaction.amount];
    }
    self.valueLabel.text = total.stringValue;
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
    return self.asset.transactions.count;
}

- (IBAction)addButtonClicked:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add a transaction"
                                                                             message:@"Enter the name and amount of the transaction you want to add."
                                                                      preferredStyle:UIAlertControllerStyleAlert]; // 1
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
        textfield.placeholder = @"name";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * textfield) {
        textfield.placeholder = @"amount";
    }];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Add"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              NSString * name = alertController.textFields[0].text;
                                                              NSString * amountAsString = alertController.textFields[1].text;
                                                              
                                                              NSDecimalNumber * amount = [NSDecimalNumber decimalNumberWithString:amountAsString];
                                                              
                                                              [[AssetManager sharedManager] addTransactionWithName:name amount:amount toAsset:self.asset];
                                                              
                                                              [self.tableView reloadData];
                                                              
                                                              [self updateValueLabel];
                                                              
                                                          }]; // 2
    
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                           }]; // 3
    
    [alertController addAction:firstAction]; // 4
    [alertController addAction:secondAction]; // 5
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"valueChangeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Transaction * transaction = self.asset.transactions[indexPath.row];
    
    cell.textLabel.text = transaction.name;
    cell.detailTextLabel.text = transaction.amount.stringValue;
    
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
        
        Transaction * transaction = self.asset.transactions[indexPath.row];
        
        [[AssetManager sharedManager] removeTransaction:transaction fromAsset:self.asset];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self updateValueLabel];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
