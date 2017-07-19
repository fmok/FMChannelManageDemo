//
//  ItemModel.m
//  DemoHaHaHa
//
//  Created by fm on 2017/7/19.
//  Copyright © 2017年 wangjiuyin. All rights reserved.
//

#import "ItemModel.h"
#import <objc/runtime.h>

@implementation ItemModel

- (id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        unsigned int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        for (int i = 0 ; i < count; i ++) {
            objc_property_t property = properties[i];
            const char *name = property_getName(property);
            NSString *propertyName = [NSString stringWithUTF8String:name];
            id propertyValue = [decoder decodeObjectForKey:propertyName];
            if (propertyValue) {
                [self setValue:propertyValue forKey:propertyName];
            }
        }
        free(properties);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0 ; i < count; i ++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [encoder encodeObject:propertyValue forKey:propertyName];
        }
    }
    free(properties);
}

@end
