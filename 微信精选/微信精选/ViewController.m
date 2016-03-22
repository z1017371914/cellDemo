//
//  ViewController.m
//  微信精选
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "WeChat.h"
#import "WXTableViewCell.h"
#import <SVWebViewController.h>
#import <MJRefresh.h>
static int pno = 1;
static int ps = 20;
static NSString *dtype = @"json";
static NSString *AppKey = @"d17276b3022746fe55fd60eb9b842e26";
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *wcArray;

@end

@implementation ViewController
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.rowHeight = 95;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [self.view addSubview:_tableView];
        [self.tableView reloadData];
        [self.tableView.mj_header beginRefreshing];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self tableView];
    [self loadData];
}
- (NSMutableArray *)wcArray{
    if (_wcArray==nil) {
        _wcArray = [NSMutableArray array];
    }
    return  _wcArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData{
    NSString *urlString= [NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?pno=%d&ps=%d&dtype=%@&key=%@",pno++,ps,dtype,AppKey];
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSLog(@"%s",__func__);
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if (!error) {
            self.wcArray = [WeChat WCsWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            });
        }
    }];
    [dataTask resume];
}

-(void)loadMoreData{
    NSString *urlString= [NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?pno=%d&ps=%d&dtype=%@&key=%@",pno++,ps,dtype,AppKey];
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSLog(@"%s",__func__);
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if (!error) {
            NSMutableArray *temp = [WeChat WCsWithData:data];
            for (WeChat * wc in temp) {
                [self.wcArray addObject:wc];
            }
            sleep(1);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            });
        }
    }];
    [dataTask resume];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.wcArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WXTableViewCell *cell = [WXTableViewCell cellWithTableView:tableView];
    cell.wc = self.wcArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeChat *wc = self.wcArray[indexPath.row];
    SVWebViewController *wv = [[SVWebViewController alloc] initWithURL:[NSURL URLWithString:wc.url]];
    wv.modalPresentationStyle = UIModalPresentationPageSheet;
   // wv.availableActions = SVWebViewControllerAvailableActionsOpenInSafari | SVWebViewControllerAvailableActionsCopyLink | SVWebViewControllerAvailableActionsMailLink;
    [self.navigationController pushViewController:wv animated:YES];
}
@end
