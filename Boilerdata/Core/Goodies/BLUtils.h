//
//  BLUtils.h
//  Boilerdata
//
//  Created by Nick Tymchenko on 07/01/16.
//  Copyright © 2016 Pixty. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BLStaticDataProvider;
@protocol BLDataItem;
@protocol BLDataDiff;

typedef void (^BLDataProviderEnumerationBlock)(id<BLDataItem> item, NSIndexPath *indexPath, BOOL *stop);


@interface BLUtils : NSObject

+ (BOOL)dataProviderIsEmpty:(id<BLStaticDataProvider>)dataProvider;

+ (NSInteger)dataProviderNumberOfItems:(id<BLStaticDataProvider>)dataProvider;

+ (void)dataProvider:(id<BLStaticDataProvider>)dataProvider enumerateItemsWithBlock:(BLDataProviderEnumerationBlock)block;


+ (BOOL)dataDiffIsEmpty:(id<BLDataDiff>)dataDiff;

@end