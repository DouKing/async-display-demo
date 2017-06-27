//
//  Demo2ViewController.m
//  async-display
//
//  Created by iosci on 2017/6/27.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import "Demo2ViewController.h"
#import "STMFPSLabel.h"

typedef BOOL(^Task)(void);

@interface Demo2ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray<Task> *tasks;
@property (nonatomic, assign) NSInteger maxQueueLength;

@end

//回调函数
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    Demo2ViewController * vc = (__bridge Demo2ViewController *)info;
    if (vc.tasks.count == 0) {
      return;
    }
    BOOL result = NO;
    while (result == NO && vc.tasks.count) {
      //取出任务
      Task unit = vc.tasks.firstObject;
      //执行任务
      result = unit();
      //干掉第一个任务
      [vc.tasks removeObjectAtIndex:0];
    }
}

@implementation Demo2ViewController

- (void)dealloc {
  [_timer invalidate];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[Demo2Cell class] forCellReuseIdentifier:NSStringFromClass([Demo2Cell class])];
  STMFPSLabel *fps = [[STMFPSLabel alloc] initWithFrame:CGRectMake(5, 64, 0, 0)];
  [self.view addSubview:fps];
  [fps sizeToFit];

  self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(_timerAction) userInfo:nil repeats:YES];
  [self _addRunloopObserver];
  self.maxQueueLength = 18;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  Demo2Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([Demo2Cell class]) forIndexPath:indexPath];
  [self _configureCell:cell atIndexPath:indexPath];
  return cell;
}

- (void)_configureCell:(Demo2Cell *)cell atIndexPath:(NSIndexPath *)indexPath {
  [cell reset];
  [cell addLabel:indexPath];
//  [cell addImage1];
//  [cell addImage2];
//  [cell addImage3];

  [self _addTask:^BOOL{
    [cell addImage1];
    return YES;
  }];
  [self _addTask:^BOOL{
    [cell addImage2];
    return YES;
  }];
  [self _addTask:^BOOL{
    [cell addImage3];
    return YES;
  }];
}

- (void)_addTask:(Task)unit {
  [self.tasks addObject:unit];
  //判断一下 保证没有来得及显示的cell不会绘制图片!!
  if (self.tasks.count > self.maxQueueLength) {
    [self.tasks removeObjectAtIndex:0];
  }
}

- (void)_addRunloopObserver {
  //获取当前RunLoop
  CFRunLoopRef runloop = CFRunLoopGetCurrent();
  //定义一个上下文
  CFRunLoopObserverContext context = {
    0,
    (__bridge void *)(self),
    &CFRetain,
    &CFRelease,
    NULL,
  };
  //定义一个观察者
  static CFRunLoopObserverRef defaultModeObserver;
  //创建观察者
  defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, NSIntegerMax - 999, &Callback, &context);
  //添加当前RunLoop的观察者
  CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopDefaultMode);
  CFRelease(defaultModeObserver);
}

- (void)_timerAction {}

#pragma mark - setter & getter

- (NSMutableArray<Task> *)tasks {
  if (!_tasks) {
    _tasks = [NSMutableArray<Task> array];
  }
  return _tasks;
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
  NSInteger tag = 1 + kTag;
  if ([self.contentView viewWithTag:tag]) {
    return;
  }
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 20, 85, 85)];
  imageView.tag = tag;
  UIImage *image = [UIImage imageNamed:@"spaceship2"];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  imageView.image = image;
  [UIView transitionWithView:self.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
    [self.contentView addSubview:imageView];
  } completion:nil];
}

- (void)addImage2 {
  NSInteger tag = 2 + kTag;
  if ([self.contentView viewWithTag:tag]) { return; }
  UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(105, 20, 85, 85)];
  imageView1.tag = tag;
  UIImage *image1 = [UIImage imageNamed:@"spaceship2"];
  imageView1.contentMode = UIViewContentModeScaleAspectFit;
  imageView1.image = image1;
  [UIView transitionWithView:self.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
    [self.contentView addSubview:imageView1];
  } completion:nil];
}

- (void)addImage3 {
  NSInteger tag = 3 + kTag;
  if ([self.contentView viewWithTag:tag]) { return; }
  UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 20, 85, 85)];
  imageView2.tag = tag;
  UIImage *image2 = [UIImage imageNamed:@"spaceship2"];
  imageView2.contentMode = UIViewContentModeScaleAspectFit;
  imageView2.image = image2;
  [UIView transitionWithView:self.contentView duration:0.3 options:(UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionTransitionCrossDissolve) animations:^{
    [self.contentView addSubview:imageView2];
  } completion:nil];
}

@end
