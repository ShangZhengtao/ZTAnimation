//
//  LIstViewController.m
//  RefreshDemo
//
//  Created by apple on 2017/9/27.
//  Copyright © 2017年 shang. All rights reserved.
//

#import "ListViewController.h"
#import "ZTHeaderRefresh.h"
#import "ZTLottieHeaderRefresh.h"
@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *lottieFiles;
@end

@implementation ListViewController

static NSString *cellID = @"cellID";
- (void)setupTableView {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,screenSize.width , screenSize.height - 64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView];
    __weak typeof(self) weakSelf = self;
    if (self.refreshStyle == 0){ //泡泡
        ZTHeaderRefresh *header = [ZTHeaderRefresh headerWithRefreshingBlock:^{
            [weakSelf requsetData];
        }];
        header.tintColor = [UIColor orangeColor];
        //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 50, 40) cornerRadius:10];
        //    header.path = path;
        self.tableView.mj_header = header;
    }else if (self.refreshStyle == 1){//lottie
        ZTLottieHeaderRefresh  *header = [ZTLottieHeaderRefresh headerWithRefreshingBlock:^{
            [weakSelf requsetData];
        }];
        header.lottieFilename = @"material_wave_loading";
        self.tableView.mj_header = header;
    }
   
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.lottieFiles = @[@"cooking_app",@"loader1",
                         @"preloader",
                         @"refresh",@"pencil_write",
                         @"material_wave_loading",
                         @"loading"];
    
    [self setupTableView];
    kDisbaleAutoAdjustScrollViewInsets(self.tableView, self);
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    self.tableView.frame = self.view.bounds;
}


- (void)requsetData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.refreshStyle == 0)return 2;
    return self.lottieFiles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSString *title = self.refreshStyle== 0 ? @"测试": self.lottieFiles[indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.refreshStyle == 1 && [self.tableView.mj_header isKindOfClass: [ZTLottieHeaderRefresh class]]){
        ZTLottieHeaderRefresh *header = (ZTLottieHeaderRefresh *)self.tableView.mj_header;
        if(header.state != MJRefreshStateRefreshing) {
            header.lottieFilename = self.lottieFiles[indexPath.row];
        }else{
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        
    }
}


@end
