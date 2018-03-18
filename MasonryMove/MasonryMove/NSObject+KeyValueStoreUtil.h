//
//  NSObject+MemorizeUtil.h
//  MasonryMove
//
//  Created by Cerko on 2018/3/17.
//  Copyright © 2018年 Cerko. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KeyValueStoreUtil)

@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSDictionary <NSString *, id> *> *keyPathValues;

- (void)jc_storeForKey:(NSString *)key keyPaths:(NSArray <NSString *> *)keyPaths;
- (void)jc_restoreForKey:(NSString *)key;
- (void)jc_clearAllStored;
@end

NS_ASSUME_NONNULL_END
