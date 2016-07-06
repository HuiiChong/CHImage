//
//  CHImage.h
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Julio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHImageCache.h"

NS_ASSUME_NONNULL_BEGIN

@interface CHImage : UIImage

/**
 * image without cache
 *
 * @param
 * name: name of image which in mainbundle
 */
+ (nullable CHImage *)imageNamedWithoutCache:(NSString *)name;

/**
 * image with cache and manage by yourself
 * and add to default namespace named "-1"
 * and it's also be global image you want to cache
 * 
 * @param
 * name: name of image which in mainbundle
 */
+ (nullable CHImage *)imageNamedByCache:(NSString *)name;

/**
 * default is cached
 * and you can make the image cache to which namespace
 *
 * @param
 * name: name of image which in mainbundle
 * ns: cache for namespace
 */
+ (nullable CHImage *)imageNamedByCache:(NSString *)name namespace:(NSString *)ns;

/**
 * save to cache
 */
- (void)saveCache:(NSString *)name namespace:(NSString *)ns;

@end

NS_ASSUME_NONNULL_END
