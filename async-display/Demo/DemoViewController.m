//
//  DemoTableViewController.m
//  async-display
//
//  Created by iosci on 2017/6/26.
//  Copyright © 2017年 secoo. All rights reserved.
//

#import "DemoViewController.h"
#import "STMFPSLabel.h"

@interface DemoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;
@property (nonatomic, strong) NSArray *strings;

@end

@implementation DemoViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.tableView registerClass:[DemoCell class] forCellReuseIdentifier:NSStringFromClass([DemoCell class])];

  STMFPSLabel *fps = [[STMFPSLabel alloc] initWithFrame:CGRectMake(5, 70, 0, 0)];
  [self.view addSubview:fps];
  [fps sizeToFit];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.strings.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  DemoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DemoCell class]) forIndexPath:indexPath];
  [self _configCell:cell atIndex:indexPath.row];
  return cell;
}

- (void)_configCell:(DemoCell *)cell atIndex:(NSUInteger)index {
  if (self.switchButton.on) {
    cell.asyncLabel.text = self.strings[index];
    cell.titleLabel.hidden = YES;
    cell.asyncLabel.hidden = NO;
  } else {
    cell.titleLabel.text = self.strings[index];
    cell.titleLabel.hidden = NO;
    cell.asyncLabel.hidden = YES;
  }
}

- (IBAction)_handleSwitchAction:(UISwitch *)sender {
  [self.tableView reloadData];
}

- (NSArray *)strings {
  if (!_strings) {
    int count = 300;
    NSMutableArray *temp = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++) {
      NSString *text = [NSString stringWithFormat:@"%d Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫 Async Display Test ✺◟(∗❛ัᴗ❛ั∗)◞✺ ✺◟(∗❛ัᴗ❛ั∗)◞✺ 😀😖😐😣😡🚖🚌🚋🎊💖💗💛💙🏨🏦🏫",i];
      [temp addObject:text];
    }
    _strings = [temp copy];
  }
  return _strings;
}

@end


@implementation DemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.asyncLabel];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.titleLabel.frame = self.bounds;
  self.asyncLabel.frame = self.bounds;
}

- (UILabel *)titleLabel {
  if (!_titleLabel) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.numberOfLines = 0;
    _titleLabel.hidden = YES;
  }
  return _titleLabel;
}

- (AsyncLabel *)asyncLabel {
  if (!_asyncLabel) {
    _asyncLabel = [[AsyncLabel alloc] init];
    _asyncLabel.font = [UIFont systemFontOfSize:12];
    _asyncLabel.textColor = [UIColor blackColor];
    _asyncLabel.numberOfLines = 0;
    _asyncLabel.hidden = YES;
  }
  return _asyncLabel;
}


@end
