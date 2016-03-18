//
//  AssetManager.m
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 14/03/16.
//  Copyright © 2016 jens. All rights reserved.
//

#import "AssetManager.h"
#import "AppDelegate.h"
#import "Asset.h"
#import "Transaction.h"
#import "AssetValueChange.h"

@implementation AssetManager

// http://www.galloway.me.uk/tutorials/singleton-classes/

// singleton
// in swift:
// static let sharedManager = AssetManager()
// private init() { ...
+ (AssetManager *)sharedManager {
    
    // static -> blijf dezelfde AssetManager gebruiken
    static AssetManager *sharedMyManager = nil;
    
    static dispatch_once_t onceToken;
    
    // dispatch_once -> gebeurt maar 1 keer
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    
    return sharedMyManager;
}

- (instancetype) init {
    if (self == [super init]) { // extra controle
        
        // stel assets in op een lege array
        self.assets = [[NSMutableArray alloc] init];
        // OF...
        [self setAssets:[[NSMutableArray alloc] init]];
        
        
        // objectContext instellen
        UIApplication * app = [UIApplication sharedApplication];
        
        AppDelegate * appDelegate = [app delegate];
        
        self.objectContext = [appDelegate managedObjectContext];
        //  OF in 1 regel:
        self.objectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
        
        // laad assets in uit coredata
        [self loadAssets];
        
        // indien geen assets -> laad default assets in
        if (self.assets.count == 0) {
            [self createDummyAssets];
            [self loadAssets];
        }
        
        return self;
    }
    return nil;
}

- (void) loadAssets {
    NSFetchRequest * fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Asset"];
    
    NSSortDescriptor * sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"sortIndex" ascending:YES];
    
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSError * error = nil;
    
    NSArray * assets = [self.objectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error == nil) {
        // we willen geen NSArray maar een NSMutableArray
        self.assets = [assets mutableCopy];
    }
    else {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

- (void) createDummyAssets {
    
    NSEntityDescription * description = [NSEntityDescription entityForName:@"Asset" inManagedObjectContext:self.objectContext];
    
    Asset * asset1 = [[Asset alloc] initWithEntity:description insertIntoManagedObjectContext:self.objectContext];
    // stel properties in...
    asset1.name = @"Eclipse Yacht";
    
    asset1.initialValue = [[NSDecimalNumber alloc] initWithDouble:650000000];
    
    
    // maak 2de asset aan
    Asset * asset2 = [[Asset alloc] initWithEntity:description insertIntoManagedObjectContext:self.objectContext];
    // stel properties in...
    asset2.name = @"Ferrari FF";
    
    asset2.initialValue = [[NSDecimalNumber alloc] initWithDouble:230000];
    
    // sla onze assets op
    NSError * error = nil;
    [self.objectContext save:&error];
    
    if (error != nil) {
         NSLog(@"error: %@", error.localizedDescription);
    }
}

- (void) addAssetWithName: (NSString *) name andInitialValue: (NSDecimalNumber *) initialValue {
    // create asset
    NSEntityDescription * description = [NSEntityDescription entityForName:@"Asset" inManagedObjectContext:self.objectContext];
    
    Asset * asset = [[Asset alloc] initWithEntity:description insertIntoManagedObjectContext:self.objectContext];
    
    asset.name = name;
    asset.initialValue = initialValue;
    
    [self.assets addObject:asset];
    
    // save
    [self save];
}

- (void) save {
    
    [self updateSortIndexes];
    
    NSError * error = nil;
    [self.objectContext save:&error];
    
    if (error != nil) {
        NSLog(@"error: %@", error.localizedDescription);
    }
}

- (void) updateSortIndexes {
    // loop through all assets
    for (int i = 0; i < self.assets.count; i++) {
        // assets.sortindex = index
        Asset * asset = self.assets[i];
        asset.sortIndex = [NSNumber numberWithInt:i];
    }
    
}

- (void) deleteAsset:(Asset*) asset {
    // first way to do something like this
    [self.objectContext deleteObject:asset];
    [self save];
    [self loadAssets];
}

- (void) deleteAssetAtIndex:(NSInteger) index {
    // alternative way
    Asset * asset = [self.assets objectAtIndex:index];
    
    [self.assets removeObjectAtIndex:index];
    
    [self.objectContext deleteObject:asset];
    [self save];
}

- (void) moveAssetAtIndex:(NSInteger) firstIndex toIndex:(NSInteger) secondIndex {
    
    Asset * assetToMove = self.assets[firstIndex]; // OF [self.assets objectAtIndex:firstIndex];
    [self.assets removeObjectAtIndex:firstIndex];
    [self.assets insertObject:assetToMove atIndex:secondIndex];
    
    [self save];
}


- (void) addTransactionWithName:(NSString *) name amount:(NSDecimalNumber *) amount toAsset: (Asset *) asset {
    NSEntityDescription * description = [NSEntityDescription entityForName:@"Transaction" inManagedObjectContext:self.objectContext];
    
    Transaction * transaction = [[Transaction alloc] initWithEntity:description insertIntoManagedObjectContext:self.objectContext];
    
    transaction.name = name;
    transaction.amount = amount;
    
    [asset addTransactionsObject:transaction];
    
    // save
    [self save];
}

- (void) removeTransaction:(Transaction *) transaction fromAsset:(Asset *) asset {
    [asset removeTransactionsObject:transaction];
    [self.objectContext deleteObject:transaction];
    [self save];
}

//- (void) addValueChangeWithName:(NSString *) name amount:(NSDecimalNumber *) amount toAsset: (Asset *) asset {
//    NSEntityDescription * description = [NSEntityDescription entityForName:@"AssetValueChange" inManagedObjectContext:self.objectContext];
//    
//    AssetValueChange * assetValueChange = [[AssetValueChange alloc] initWithEntity:description insertIntoManagedObjectContext:self.objectContext];
//    
//    assetValueChange.name = name;
//    assetValueChange.amountChanged = amount;
//    
//    [asset addValueChangesObject:assetValueChange];
//    
//    [self save];
//}

@end





