//
//  Asset+CoreDataProperties.h
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 15/03/16.
//  Copyright © 2016 jens. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Asset.h"

NS_ASSUME_NONNULL_BEGIN

@interface Asset (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDecimalNumber *initialValue;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *sortIndex;

@end

NS_ASSUME_NONNULL_END
