//
//  BLAbstractDataProvider+Subclassing.h
//  Boilerdata
//
//  Created by Nick Tymchenko on 06/01/16.
//  Copyright © 2016 Pixty. All rights reserved.
//

#import <Boilerdata/BLAbstractDataProvider.h>

@protocol BLData;
@class BLDataEvent;
@class BLDataEventCallbacks;

NS_ASSUME_NONNULL_BEGIN


@interface BLAbstractDataProvider ()

- (void)updateWithBlock:(void (^)(__kindof id<BLData> lastQueuedData))block;

- (void)enqueueDataEvent:(BLDataEvent *)event;
- (void)enqueueDataEvent:(BLDataEvent *)event callbacks:(nullable BLDataEventCallbacks *)callbacks;

@end


@interface BLAbstractDataProvider (Overridable)

/**
 * Override this method to customize initial data. Default is [BLEmptyData data].
 */
- (id<BLData>)createInitialData;

@end


NS_ASSUME_NONNULL_END
