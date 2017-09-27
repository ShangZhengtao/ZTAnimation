//
//  ViewController.m
//  RefreshDemo
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ViewController.h"
#import "ZTHeaderRefresh.h"
#import "ZTLottieHeaderRefresh.h"
#import "ListViewController.h"
@interface ViewController ()
<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

static NSString *cellID = @"cellID";

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    __weak typeof(self) weakSelf = self;
//    ZTHeaderRefresh *header = [ZTHeaderRefresh headerWithRefreshingBlock:^{
//        [weakSelf requsetData];
//    }];
//    header.tintColor = [UIColor orangeColor];
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 50, 40) cornerRadius:10];
//    header.path = path;
    
//  ZTLottieHeaderRefresh  *header = [ZTLottieHeaderRefresh headerWithRefreshingBlock:^{
//        [weakSelf requsetData];
//    }];
//    header.lottieFilename = @"material_wave_loading";
//    self.tableView.mj_header = header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    kDisbaleAutoAdjustScrollViewInsets(self.tableView, self);
}

- (void)requsetData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:indexPath.row==0?@"泡泡":@"lottie"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ListViewController *listVC = [[ListViewController alloc]init];
    listVC.title = [NSString stringWithFormat:indexPath.row==0?@"泡泡":@"lottie"];
    listVC.refreshStyle = indexPath.row;
    [self.navigationController pushViewController:listVC animated:YES];
}



@end
