//
//  STMAsyncLayer.h
//  async-display
//
//  Created by iosci on 2017/6/26.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
@class STMAsyncLayerDisplayTask;


@interface STMAsyncLayer : CALayer

// default is YES
@property BOOL displaysAsynchronously;

@end


@protocol STMAsyncLayerDelegate <NSObject>
@required
- (STMAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end


@interface STMAsyncLayerDisplayTask : NSObject

@property (nullable, nonatomic, copy) void (^willDisplay)(CALayer *layer);
@property (nullable, nonatomic, copy) void (^display)(CGContextRef context, CGSize size, BOOL(^isCancelled)(void));
@property (nullable, nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);

@end


NS_ASSUME_NONNULL_END
