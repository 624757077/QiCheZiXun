//
//  LatestViewController.m
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "LatestViewController.h"
#import "LatestCell.h"
#import "LatestViewModel.h"
#import "ScrollDisplayViewController.h"
#import "DetailViewController.h"
@interface LatestViewController ()<UITableViewDelegate, UITableViewDataSource, ScrollDisplayViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) LatestViewModel *latestVM;

@property(nonatomic,strong) ScrollDisplayViewController *sdVC;

@end

@implementation LatestViewController
- (LatestViewModel *)latestVM{
    if (!_latestVM) {
        _latestVM = [[LatestViewModel alloc] initWithNewsListType:_type];
    }
    return _latestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.latestVM refreshDataCompleteHandle:^(NSError *error) {
            [_tableView.mj_header endRefreshing];
            [_tableView reloadData];
            if (error) {
                [self showErrorMsg:error.localizedDescription];
            }
            [self configTableHeader];
        }];
        
    }];
    
    _tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self.latestVM getMoreDataCompleteHandle:^(NSError *error) {
            if (error) {
                [self showErrorMsg:error.description];
            }
            [_tableView.mj_footer endRefreshing];
            [_tableView reloadData];
        }];
        
    }];
    
    [_tableView.mj_header beginRefreshing];
}

- (void)configTableHeader{
    if (self.latestVM.headImageURLs.count == 0) {
        return;
    }
    
    UIView *headerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 185)];
    //把之前的child移除，再新建
    [_sdVC removeFromParentViewController];
    _sdVC = [[ScrollDisplayViewController alloc] initWithImgPaths:self.latestVM.headImageURLs];
    _sdVC.delegate = self;
    [self addChildViewController:_sdVC];
    [headerView addSubview:_sdVC.view];
    [_sdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(headerView);
    }];
    _tableView.tableHeaderView = headerView;
}
- (void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController didSelectedIndex:(NSInteger)index{
    DDLogVerbose(@"%ld", (long)index);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.latestVM.rowNumber;
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LatestCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell.iconIV sd_setImageWithURL:[self.latestVM iconURLForRow:indexPath.row]];
    cell.titleLb.text = [self.latestVM titleForRow:indexPath.row];
    cell.dateLb.text = [self.latestVM dateForRow:indexPath.row];
    cell.commentLb.text = [self.latestVM commentNumberForRow:indexPath.row];
    return cell;
}
//让分割线左侧无空隙
kRemoveCellSeparator
//松手后 去掉高亮状态
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc=[[DetailViewController alloc] initWithID:[self.latestVM IDForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
