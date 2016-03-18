//
//  Transaction+CoreDataProperties.h
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 17/03/16.
//  Copyright © 2016 jens. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Transaction.h"

NS_ASSUME_NONNULL_BEGIN

@interface Transaction (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDecimalNumber *amount;

@end

NS_ASSUME_NONNULL_END
