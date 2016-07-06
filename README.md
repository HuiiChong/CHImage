# CHImage
1.It's use to instead of UIImage, and manage image cache by youself.

For use image without cache, you can use the method:
+ (nullable CHImage *)imageNamedWithoutCache:(NSString *)name;

For use image with cache, and add the cache to the default group "-1":
+ (nullable CHImage *)imageNamedByCache:(NSString *)name;

For use image with cache, and add the cache to the customize group.this like for,
when you exit to a viewController, and you only want to clear images of this 
viewController used. so you can add these images to a customize group and clear 
the group when you exit.
+ (nullable CHImage *)imageNamedByCache:(NSString *)name namespace:(NSString *)ns;

2.FOR clear the image caches, you can use the class: CHImageCache

For clear image by name:
- (void)clearImageCachedByName:(NSString *)name;

For clear images in group:
- (void)clearImageCached:(NSString *)ns;

For clear all images cache:
- (void)clearAllImageCached;
