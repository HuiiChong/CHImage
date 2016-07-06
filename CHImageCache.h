//
//  CHImageCache.h
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Julio. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CHImage;

@interface CHImageCache : NSObject

+ (CHImageCache *)sharedImageCache;

/**
 * add image cache
 */
- (void)addImageCacheByNamespace:(NSString *)name namespace:(NSString *)ns image:(CHImage *)image;

/**
 * get image cache
 */
- (CHImage *)getCacheImageByName:(NSString *)name namespace:(NSString *)ns;

/**
 * clear one of cached images by name
 *
 * @param
 * name: name of image
 */
- (void)clearImageCachedByName:(NSString *)name;

/**
 * clear all the cached images of namespace
 *
 * @param
 * ns: namespace for cached image
 */
- (void)clearImageCached:(NSString *)ns;

/**
 * clear all cached images
 */
- (void)clearAllImageCached;

@end

NS_ASSUME_NONNULL_END
