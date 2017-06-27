//
//  Demo2ViewController.m
//  async-display
//
//  Created by iosci on 2017/6/27.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import "Demo2ViewController.h"
#import "STMFPSLabel.h"

@interface Demo2ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation Demo2ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[Demo2Cell class] forCellReuseIdentifier:NSStringFromClass([Demo2Cell class])];

  STMFPSLabel *fps = [[STMFPSLabel alloc] initWithFrame:CGRectMake(5, 64, 0, 0)];
  [self.view addSubview:fps];
  [fps sizeToFit];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  Demo2Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Demo2Cell class]) forIndexPath:indexPath];
  [cell reset];
  [cell addLabel:indexPath];
  [cell addImage1];
  [cell addImage2];
  [cell addImage3];
  return cell;
}

@end


static NSInteger const kTag = 1000;
@implementation Demo2Cell

- (void)reset {
  for (int i = 1; i <= 5; i++) {
    NSInteger tag = i + kTag;
    [[self.contentView viewWithTag:tag] removeFromSuperview];
  }
}

- (void)addLabel:(NSIndexPath *)indexPath {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 300, 25)];
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor redColor];
  label.text = [NSString stringWithFormat:@"%zd - Drawing index is top priority", indexPath.row];
  label.font = [UIFont boldSystemFontOfSize:13];
  label.tag = 4 + kTag;
  [self.contentView addSubview:label];

  UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 99, 300, 35)];
  label1.lineBreakMode = NSLineBreakByWordWrapping;
  label1.numberOfLines = 0;
  label1.backgroundColor = [UIColor clearColor];
  label1.textColor = [UIColor colorWithRed:0 green:100.f/255.f blue:0 alpha:1];
  label1.text = [NSString stringWithFormat:@"%zd - Drawing large image is low priority. Should be distributed into different run loop passes.", indexPath.row];
  label1.font = [UIFont boldSystemFontOfSize:13];
  label1.tag = 5 + kTag;
  [self.contentView addSubview:label1];
}

- (void)addImage1 {
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 85, 85)];
  imageView.tag = 1 + kTag;
  UIImage *image = [UIImage imageNamed:@"spaceship2"];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  imageView.image = image;
  [UIView transitionWithView:self.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
    [self.contentView addSubview:imageView];
  } completion:nil];
}

- (void)addImage2 {
  UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(105, 20, 85, 85)];
  imageView1.tag = 2 + kTag;
  UIImage *image1 = [UIImage imageNamed:@"spaceship2"];
  imageView1.contentMode = UIViewContentModeScaleAspectFit;
  imageView1.image = image1;
  [UIView transitionWithView:self.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
    [self.contentView addSubview:imageView1];
  } completion:nil];
}

- (void)addImage3 {
  UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 20, 85, 85)];
  imageView2.tag = 3 + kTag;
  UIImage *image2 = [UIImage imageNamed:@"spaceship2"];
  imageView2.contentMode = UIViewContentModeScaleAspectFit;
  imageView2.image = image2;
  [UIView transitionWithView:self.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
    [self.contentView addSubview:imageView2];
  } completion:nil];
}

@end
