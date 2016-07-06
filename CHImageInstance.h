//
//  CHImageInstance.h
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Julio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHImage.h"

NS_ASSUME_NONNULL_BEGIN

@interface CHImageInstance : NSObject

@property (nullable,strong, nonatomic) CHImage *image;
@property (nullable,copy, nonatomic) NSString *ns;

@end

NS_ASSUME_NONNULL_END
