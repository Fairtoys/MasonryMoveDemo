//
//  NSObject+MemorizeUtil.m
//  MasonryMove
//
//  Created by Cerko on 2018/3/17.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import "NSObject+KeyValueStoreUtil.h"
#import <objc/runtime.h>


@implementation NSObject (KeyValueStoreUtil)

- (NSMutableDictionary<NSString *,NSDictionary<NSString *,id> *> *)keyPathValues{
    NSMutableDictionary<NSString *,NSDictionary<NSString *,id> *> *keyPathValues = objc_getAssociatedObject(self, _cmd);
    if (!keyPathValues) {
        keyPathValues = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, keyPathValues, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return keyPathValues;
}

- (void)jc_storeForKey:(NSString *)key keyPaths:(NSArray <NSString *> *)keyPaths{
    if (!keyPaths) {
        return ;
    }
    NSDictionary <NSString *, id> * keyPathValues = [self dictionaryWithValuesForKeys:keyPaths];
    self.keyPathValues[key] = keyPathValues;
}

- (void)jc_restoreForKey:(NSString *)key{
    NSDictionary <NSString *, id> * keyPathValues = self.keyPathValues[key];
    if (!keyPathValues) {
        return ;
    }
    
    [self setValuesForKeysWithDictionary:keyPathValues];
}

- (void)jc_clearAllStored{
    objc_setAssociatedObject(self, _cmd, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
