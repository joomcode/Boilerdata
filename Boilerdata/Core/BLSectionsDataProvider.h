//
//  BLSectionsDataProvider.h
//  Boilerdata
//
//  Created by Makarov Yury on 21/03/16.
//  Copyright © 2016 Pixty. All rights reserved.
//

#import "BLBasicDataProvider.h"

@protocol BLDataItemId;
@protocol BLDataSection;

NS_ASSUME_NONNULL_BEGIN


@interface BLSectionsDataProvider : BLBasicDataProvider

- (void)updateWithSections:(nullable NSArray<id<BLDataSection>> *)sections;

- (void)updateWithSections:(nullable NSArray<id<BLDataSection>> *)sections updatedItemIds:(nullable NSSet<id<BLDataItemId>> *)updatedItemIds;

- (void)updateWithSections:(nullable NSArray<id<BLDataSection>> *)sections
            updatedItemIds:(nullable NSSet<id<BLDataItemId>> *)updatedItemIds
                   context:(nullable NSDictionary *)context;

@end

NS_ASSUME_NONNULL_END