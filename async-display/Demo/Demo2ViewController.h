//
//  Demo2ViewController.h
//  async-display
//
//  Created by iosci on 2017/6/27.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Demo2ViewController : UIViewController

@end

@interface Demo2Cell : UITableViewCell

- (void)reset;
- (void)addLabel:(NSIndexPath *)indexPath;
- (void)addImage1;
- (void)addImage2;
- (void)addImage3;

@end
