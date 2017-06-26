//
//  STMSentinel.m
//  async-display
//
//  Created by iosci on 2017/6/26.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import "STMSentinel.h"
#import <libkern/OSAtomic.h>

@implementation STMSentinel {
  int32_t _value;
}

- (int32_t)value {
  return _value;
}

- (int32_t)increase {
  return OSAtomicIncrement32(&_value);
}

@end
