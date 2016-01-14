//
//  BLAbstractDataProvider.m
//  Boilerdata
//
//  Created by Nick Tymchenko on 06/01/16.
//  Copyright © 2016 Pixty. All rights reserved.
//

#import "BLAbstractDataProvider.h"
#import "BLAbstractDataProvider+Subclassing.h"
#import "BLStaticDataProviderProxy+Subclassing.h"
#import "BLDataEvent.h"
#import "BLDataEventProcessor.h"
#import "BLDataObserver.h"
#import "BLNilDataEventProcessor.h"

@interface BLAbstractDataProvider ()

@property (nonatomic, readonly) NSMutableArray<BLDataEvent *> *eventQueue;
@property (nonatomic, readonly) NSMutableArray<BLAbstractDataProviderEventCallbacks *> *eventCallbacksQueue;

@property (nonatomic, strong) id<BLDataEventProcessor> eventProcessorInProgress;

@end


@implementation BLAbstractDataProvider

#pragma mark - BLDataProvider

@synthesize observer = _observer;
@synthesize locked = _locked;

#pragma mark - Protected

- (void)enqueueDataEvent:(BLDataEvent *)event {
    [self enqueueDataEvent:event callbacks:nil];
}

- (void)enqueueDataEvent:(BLDataEvent *)event callbacks:(BLAbstractDataProviderEventCallbacks *)callbacks {
    NSParameterAssert(event != nil);
    
    _lastQueuedEvent = event;
    
    [self.eventQueue addObject:event];
    [self.eventCallbacksQueue addObject:callbacks ?: [[BLAbstractDataProviderEventCallbacks alloc] init]];
    
    [self dequeueEventIfPossible];
}

#pragma mark - Private

@synthesize eventQueue = _eventQueue;
@synthesize eventCallbacksQueue = _eventCallbacksQueue;

- (NSMutableArray<BLDataEvent *> *)eventQueue {
    if (!_eventQueue) {
        _eventQueue = [[NSMutableArray alloc] init];
    }
    return _eventQueue;
}

- (NSMutableArray<BLAbstractDataProviderEventCallbacks *> *)eventCallbacksQueue {
    if (!_eventCallbacksQueue) {
        _eventCallbacksQueue = [[NSMutableArray alloc] init];
    }
    return _eventCallbacksQueue;
}

- (void)dequeueEventIfPossible {
    if (self.eventQueue.count == 0 || self.locked || self.eventProcessorInProgress) {
        return;
    }
    
    BLDataEvent *event = self.eventQueue.firstObject;
    BLAbstractDataProviderEventCallbacks *callbacks = self.eventCallbacksQueue.firstObject;
    [self.eventQueue removeObjectAtIndex:0];
    [self.eventCallbacksQueue removeObjectAtIndex:0];
    
    self.eventProcessorInProgress = [self getProcessorForEvent:event];
    
    if (callbacks.willProcessBlock) {
        callbacks.willProcessBlock(self.eventProcessorInProgress);
    }
    
    [self.eventProcessorInProgress applyEvent:event withDataUpdateBlock:^{
        // TODO: post notification?
        self.staticDataProvider = event.updatedDataProvider;
        // TODO: post notification?
    } completion:^{
        self.eventProcessorInProgress = nil;
        
        if (callbacks.didProcessBlock) {
            callbacks.didProcessBlock();
        }
        
        [self dequeueEventIfPossible];
    }];
}

- (id<BLDataEventProcessor>)getProcessorForEvent:(BLDataEvent *)event {
    id<BLDataEventProcessor> processor = [self.observer dataProvider:self willUpdateWithEvent:event];
    
    if (!processor) {
        processor = [BLNilDataEventProcessor sharedInstance];
    }
    
    return processor;
}

@end