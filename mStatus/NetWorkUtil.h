//
//  NetWorkUtil.h
//  mStatus
//
//  Created by Jerry Chen on 2020/7/11.
//  Copyright © 2020 cc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkUtil : NSObject
+ (NSString *)getByteRate;
+ (long)getLastInBytes ;
@end

NS_ASSUME_NONNULL_END
