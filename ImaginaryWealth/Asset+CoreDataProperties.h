//
//  Asset+CoreDataProperties.h
//  ImaginaryWealth
//
//  Created by Jens Bruggemans on 17/03/16.
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
@property (nullable, nonatomic, retain) NSOrderedSet<Transaction *> *transactions;

@end

@interface Asset (CoreDataGeneratedAccessors)

- (void)insertObject:(Transaction *)value inTransactionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTransactionsAtIndex:(NSUInteger)idx;
- (void)insertTransactions:(NSArray<Transaction *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTransactionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTransactionsAtIndex:(NSUInteger)idx withObject:(Transaction *)value;
- (void)replaceTransactionsAtIndexes:(NSIndexSet *)indexes withTransactions:(NSArray<Transaction *> *)values;
- (void)addTransactionsObject:(Transaction *)value;
- (void)removeTransactionsObject:(Transaction *)value;
- (void)addTransactions:(NSOrderedSet<Transaction *> *)values;
- (void)removeTransactions:(NSOrderedSet<Transaction *> *)values;

@end

NS_ASSUME_NONNULL_END
