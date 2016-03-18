//
//  AddAssetViewController.m
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 15/03/16.
//  Copyright © 2016 jens. All rights reserved.
//

#import "AddAssetViewController.h"

@interface AddAssetViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end

@implementation AddAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelClicked:(id)sender {
    [self.delegate addAssetViewControllerCancelClicked:self];
}

- (IBAction)saveClicked:(id)sender {
    [self.delegate addAssetViewControllerSaveClicked:self];
}

// getter method for property name
- (NSString *) name {
    return self.nameTextField.text;
}

// setter method for property name
- (void) setName:(NSString *)name {
    self.nameTextField.text = name;
}

- (NSDecimalNumber *) initialValue {
    NSString * valueAsString = self.valueTextField.text;
    NSDecimalNumber * value = [NSDecimalNumber decimalNumberWithString:valueAsString];
    return value;
}

- (void) setInitialValue:(NSDecimalNumber *)initialValue {
    self.valueTextField.text = initialValue.stringValue;
}
- (IBAction)hideKeyboardPressed:(id)sender {
//    [self.nameTextField resignFirstResponder];
//    [self.valueTextField resignFirstResponder];
    
    [self.view endEditing:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
