//
//  CHImageCache.m
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Julio. All rights reserved.
//

#import "CHImageCache.h"
#import "CHImageInstance.h"
#import "CHImage.h"

@interface CHImageCache ()
{
    NSMutableDictionary              *_caches;
    dispatch_semaphore_t             _lock;
    NSOperationQueue                 *_queue;
}

@end

@implementation CHImageCache

+ (CHImageCache *)sharedImageCache
{
    static CHImageCache *_imageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageCache = [[CHImageCache alloc] init];
    });
    return _imageCache;
}

- (instancetype)init
{
    self = [super init];
    if(self){
        _caches = @{}.mutableCopy;
        _lock = dispatch_semaphore_create(1);
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (CHImage *)getCacheImageByName:(NSString *)name namespace:(NSString *)ns
{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    CHImageInstance *_instance = [_caches objectForKey:name];
    dispatch_semaphore_signal(_lock);
    if(_instance){
        return _instance.image;
    }
    return nil;
}

- (void)addImageCacheByNamespace:(NSString *)name namespace:(NSString *)ns image:(CHImage *)image
{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    CHImageInstance *_instance = [_caches objectForKey:name];
    if(_instance){
        dispatch_semaphore_signal(_lock);
        return;
    }
    _instance = [[CHImageInstance alloc] init];
    _instance.image = image;
    _instance.ns = ns;
    [_caches setObject:_instance forKey:name];
    dispatch_semaphore_signal(_lock);
}

- (void)clearImageCachedByName:(NSString *)name
{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_caches removeObjectForKey:name];
    dispatch_semaphore_signal(_lock);
}

- (void)clearImageCached:(NSString *)ns
{
    NSInvocationOperation *_invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(_clearOperation:) object:ns];
    [_queue addOperation:_invocation];
}

- (void)clearAllImageCached
{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    [_caches removeAllObjects];
    dispatch_semaphore_signal(_lock);
}

- (void)_clearOperation:(NSString *)ns
{
    dispatch_semaphore_wait(_lock, DISPATCH_TIME_FOREVER);
    NSMutableArray *_keys = @[].mutableCopy;
    for (NSInteger i=0; i<_caches.allKeys.count; i++) {
        NSString *_key = _caches.allKeys[i];
        CHImageInstance *_instance = [_caches objectForKey:_key];
        if(_instance&&[_instance.ns isEqualToString:ns]){
            [_keys addObject:_key];
        }
    }
    [_caches removeObjectsForKeys:_keys];
    dispatch_semaphore_signal(_lock);
}

@end
