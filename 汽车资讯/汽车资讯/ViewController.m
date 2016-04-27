//
//  ViewController.m
//  汽车资讯
//
//  Created by 冯益鹏 on 16/4/24.
//  Copyright © 2016年 FengYiPeng. All rights reserved.
//

#import "ViewController.h"
#import "ScrollDisplayViewController.h"
#import "LatestViewController.h"

@interface ViewController ()<ScrollDisplayViewControllerDelegate>
@property(nonatomic,strong) ScrollDisplayViewController *sdVC;
@property(nonatomic,strong) UIScrollView *scrollView;
//可变数组，存放头部按钮
@property(nonatomic,strong) NSMutableArray *btns;
//线
@property(nonatomic,strong) UIView *lineView;
//用于保存当前选中的按钮
@property(nonatomic,strong) UIButton *currentBtn;
@end
@implementation ViewController
-(void)scrollDisplayViewController:(ScrollDisplayViewController *)scrollDisplayViewController currentIndex:(NSInteger)index{
    _currentBtn.selected = NO;
    _currentBtn = _btns[index];
    _currentBtn.selected = YES;
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(2);
        make.centerX.mas_equalTo(_currentBtn);
        make.top.mas_equalTo(_currentBtn.mas_bottom).mas_equalTo(8);
    }];
}

- (NSMutableArray *)btns{
    if (!_btns) {
        _btns=[NSMutableArray new];
    }
    return _btns;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor=kRGBColor(56, 106, 198);
    }
    return _lineView;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        NSArray *arr=@[@"技术",@"游记",@"导购",@"评测",@"文化",@"最新",@"改装",@"行情",@"用车",@"新闻"];
        UIView *lastView=nil; //指向最新添加的按钮
        for (int i= 0; i< arr.count; i++) {
            UIButton *btn=[UIButton buttonWithType:0];
            [btn setTitle:arr[i] forState:0];
            [btn setTitleColor:kRGBColor(89, 89, 89) forState:UIControlStateNormal];
            [btn setTitleColor:self.lineView.backgroundColor forState:UIControlStateSelected];
            if (i == 0) {
                _currentBtn = btn;
                btn.selected = YES;
            }
            [btn bk_addEventHandler:^(UIButton *sender) {
                // 如果当前按钮是点击状态，什么都不做
                // 否则取消掉之前按钮的点击状态，并把当前按钮设置为点击状态
                if (_currentBtn != sender) {
                    _currentBtn.selected = NO;
                    sender.selected = YES;
                    _currentBtn = sender;
                    
                    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.width.mas_equalTo(40);
                        make.height.mas_equalTo(2);
                        make.centerX.mas_equalTo(sender);
                        make.top.mas_equalTo(sender.mas_bottom).mas_equalTo(8);
                    }];
                    _sdVC.currentPage=[_btns indexOfObject:sender];
                }
            } forControlEvents:UIControlEventTouchUpInside];
            
            [_scrollView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(45, 24));
                make.centerY.mas_equalTo(_scrollView);
                if (lastView) { //表示已经添加过按钮
                    make.left.mas_equalTo(lastView.mas_right).mas_equalTo(10);
                }else{
                    make.left.mas_equalTo(10);
                }
            }];
            lastView = btn;
            [self.btns addObject:btn];
        }
        //设置按钮的右边缘距离父视图ContentView的右边缘距离10像素
        
        [lastView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_scrollView.mas_right).mas_equalTo(-10);
        }];
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [_scrollView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(2);
            UIButton *btn=_btns[0];
            make.centerX.mas_equalTo(btn);
            make.top.mas_equalTo(btn.mas_bottom).mas_equalTo(8);
        }];
        
    }
    return _scrollView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.scrollView.hidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.scrollView.hidden = YES;
}



- (LatestViewController *)latestVCWithType:(NewsListType)type{
    LatestViewController *vc = [kStoryboard(@"Main") instantiateViewControllerWithIdentifier:@"LatestViewController"];
    vc.type = type;
    return vc;
}
- (ScrollDisplayViewController *)sdVC{
    if (!_sdVC) {
        NSArray*vcs=@[[self latestVCWithType:NewsListTypeJiShu],
                      [self latestVCWithType:NewsListTypeYouJi],
                      [self latestVCWithType:NewsListTypeDaoGou],
                      [self latestVCWithType:NewsListTypePingCe],
                      [self latestVCWithType:NewsListTypeWenHua],
                      [self latestVCWithType:NewsListTypeZuiXin],
                      [self latestVCWithType:NewsListTypeGaiZhuang],
                      [self latestVCWithType:NewsListTypeHangQing],
                      [self latestVCWithType:NewsListTypeYongChe],
                      [self latestVCWithType:NewsListTypeXinWen],
                      ];
        _sdVC=[[ScrollDisplayViewController alloc] initWithControllers:vcs];
        _sdVC.autoCycle = NO;
        _sdVC.showPageControl = NO;
        _sdVC.delegate = self;
    }
    return _sdVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.sdVC];
    [self.view addSubview:self.sdVC.view];
    [self.sdVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.navigationController.navigationBar addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end