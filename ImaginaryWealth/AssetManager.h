//
//  AssetManager.h
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 14/03/16.
//  Copyright © 2016 jens. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Asset.h"

@interface AssetManager : NSObject

+ (AssetManager *) sharedManager;

@property NSMutableArray * assets;

@property NSManagedObjectContext * objectContext;

- (void) addAssetWithName: (NSString *) name andInitialValue: (NSDecimalNumber *) initialValue;

- (void) deleteAsset:(Asset*) asset;
- (void) deleteAssetAtIndex:(NSInteger) index;

- (void) moveAssetAtIndex:(NSInteger) firstIndex toIndex:(NSInteger) secondIndex;

- (void) addTransactionWithName:(NSString *) name amount:(NSDecimalNumber *) amount toAsset: (Asset *) asset;

- (void) removeTransaction:(Transaction *) transaction fromAsset:(Asset *) asset;

- (void) save;

@end
