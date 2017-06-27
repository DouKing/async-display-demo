//
//  DemoTableViewController.h
//  async-display
//
//  Created by iosci on 2017/6/26.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncLabel.h"

@interface DemoViewController : UIViewController

@end


@interface DemoCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) AsyncLabel *asyncLabel;

@end
