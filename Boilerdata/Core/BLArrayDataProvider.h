//
//  BLArrayDataProvider.h
//  Boilerdata
//
//  Created by Nick Tymchenko on 06/01/16.
//  Copyright © 2016 Pixty. All rights reserved.
//

#import <Boilerdata/BLBasicDataProvider.h>

@protocol BLDataItem;
@protocol BLDataItemId;

NS_ASSUME_NONNULL_BEGIN


@interface BLArrayDataProvider : BLBasicDataProvider

- (void)updateWithItems:(nullable NSArray<id<BLDataItem>> *)items;

- (void)updateWithItems:(nullable NSArray<id<BLDataItem>> *)items updatedItemIds:(nullable NSSet<id<BLDataItemId>> *)updatedItemIds;

- (void)updateWithItems:(nullable NSArray<id<BLDataItem>> *)items
         updatedItemIds:(nullable NSSet<id<BLDataItemId>> *)updatedItemIds
                context:(nullable NSDictionary *)context;

@end


NS_ASSUME_NONNULL_END
