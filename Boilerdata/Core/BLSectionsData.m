//
//  BLSectionsData.m
//  Boilerdata
//
//  Created by Nick Tymchenko on 20/02/16.
//  Copyright © 2016 Pixty. All rights reserved.
//

#import "BLSectionsData.h"
#import "BLDataItem.h"
#import "BLDataSection.h"
#import "BLDataUtils.h"
#import "NSIndexPath+BLUtils.h"

@implementation BLSectionsData

#pragma mark - Init

- (instancetype)init {
    return [self initWithSections:nil];
}

- (instancetype)initWithSections:(NSArray<id<BLDataSection>> *)sections {
    self = [super init];
    if (!self) return nil;
    
    _sections = [sections copy] ?: @[];
    
    return self;
}

#pragma mark - BLData

- (NSInteger)numberOfSections {
    return self.sections.count;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (id<BLDataItem>)itemAtIndexPath:(NSIndexPath *)indexPath {
    BOOL (^validateIndexPath)(NSArray<id<BLDataSection>> *) = ^BOOL (NSArray<id<BLDataSection>> *sections) {
        return indexPath.bl_section < sections.count && indexPath.bl_row < sections[indexPath.bl_section].items.count;
    };
    NSParameterAssert(validateIndexPath(self.sections));
    return validateIndexPath(self.sections) ? self.sections[indexPath.bl_section].items[indexPath.bl_row] : nil;
}

- (NSIndexPath *)indexPathForItemWithId:(id<BLDataItemId>)itemId {
    // TODO: improve this
    
    for (NSInteger section = 0; section < self.sections.count; ++section) {
        __block NSIndexPath *result = nil;
        
        [self.sections[section].items enumerateObjectsUsingBlock:^(id<BLDataItem> item, NSUInteger idx, BOOL *stop) {
            if ([item.itemId isEqual:itemId]) {
                result = [NSIndexPath bl_indexPathForRow:idx inSection:section];
                *stop = YES;
            }
        }];
        
        if (result) {
            return result;
        }
    }
    
    return nil;
}

- (id<BLSectionItem>)itemForSection:(NSInteger)section {
    return self.sections[section].sectionItem;
}

#pragma mark - NSObject

- (NSString *)description {
    return [BLDataUtils(self) description];
}

@end
