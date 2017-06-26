//
//  STMSentinel.h
//  async-display
//
//  Created by iosci on 2017/6/26.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface STMSentinel : NSObject

/// Returns the current value of the counter.
@property (readonly) int32_t value;

/// Increase the value atomically.
/// @return The new value.
- (int32_t)increase;

@end


NS_ASSUME_NONNULL_END
