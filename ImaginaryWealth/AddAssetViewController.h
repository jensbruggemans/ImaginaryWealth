//
//  AddAssetViewController.h
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 15/03/16.
//  Copyright © 2016 jens. All rights reserved.
//

#import <UIKit/UIKit.h>

//// there will be a protocol with this name
//@protocol AddAssetViewControllerDelegate;
//
// there will be a class with this name
@class AddAssetViewController;



///////////////
@protocol AddAssetViewControllerDelegate <NSObject>

- (void) addAssetViewControllerSaveClicked:(AddAssetViewController *) viewController;

- (void) addAssetViewControllerCancelClicked:(AddAssetViewController *) viewController;

@end
///////////////


// INTERFACE
///////////////
@interface AddAssetViewController : UIViewController

@property NSObject <AddAssetViewControllerDelegate> * delegate;

@property NSString * name;

@property NSDecimalNumber * initialValue;

@end
///////////////




