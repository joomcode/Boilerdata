//
//  BLDataEvent.m
//  Boilerdata
//
//  Created by Nick Tymchenko on 05/01/16.
//  Copyright © 2016 Pixty. All rights reserved.
//

#import "BLDataEvent.h"
#import "BLEmptyData.h"

@implementation BLDataEvent

- (instancetype)initWithOldData:(id<BLData>)oldData newData:(id<BLData>)newData {
    return [self initWithOldData:oldData newData:newData updatedItemIds:nil context:nil];
}

- (instancetype)initWithOldData:(id<BLData>)oldData
                        newData:(id<BLData>)newData
                 updatedItemIds:(NSSet<id<BLDataItemId>> *)updatedItemIds
                        context:(NSDictionary *)context {
    self = [super init];
    if (!self) return nil;
 
    _oldData = oldData;
    _newData = newData;
    _updatedItemIds = [updatedItemIds copy] ?: [NSSet set];
    _context = [context copy] ?: @{};
    
    return self;    
}

+ (instancetype)empty {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BLDataEvent alloc] initWithOldData:[BLEmptyData data] newData:[BLEmptyData data]];
    });
    return instance;
}

#pragma mark - NSObject

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithString:[super description]];
    [description appendString:@" {\n"];
    [description appendFormat:@"  oldData: %@\n", self.oldData];
    [description appendFormat:@"  newData: %@\n", self.newData];
    [description appendFormat:@"  updatedItemIds: %@\n", self.updatedItemIds.count > 0 ? self.updatedItemIds : @"empty"];
    [description appendFormat:@"  context: %@\n", self.context.count > 0 ? self.context : @"empty"];
    [description appendString:@"}"];
    return [description copy];
}

@end
