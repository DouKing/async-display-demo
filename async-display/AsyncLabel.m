//
//  STMAsyncLabel.m
//  async-display
//
//  Created by iosci on 2017/6/26.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import "AsyncLabel.h"

@interface AsyncLabel()<STMAsyncLayerDelegate>

@end

@implementation AsyncLabel

+ (Class)layerClass {
  return [STMAsyncLayer class];
}

- (STMAsyncLayer *)asyncLayer {
  return (STMAsyncLayer *)self.layer;
}

- (STMAsyncLayerDisplayTask *)newAsyncDisplayTask {
  __weak typeof(self) weakSelf = self;

  STMAsyncLayerDisplayTask *task = [[STMAsyncLayerDisplayTask alloc] init];
  task.display = ^(CGContextRef  _Nonnull context, CGSize size, BOOL (^ _Nonnull isCancelled)(void)) {
    [weakSelf.text drawInRect:CGRectMake(0, 0, size.width, size.height)
               withAttributes:@{NSFontAttributeName : weakSelf.font,
                                NSForegroundColorAttributeName : weakSelf.textColor}];
  };
  return task;
}

@end
