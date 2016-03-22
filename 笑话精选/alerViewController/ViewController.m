//
//  ViewController.m
//  alerViewController
//
//  Created by apple on 16/2/3.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "Joke.h"
#import "JokeTableViewCell.h"
#import "MJRefresh.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UIAlertController *alert;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) long long currentTime;
@end


@implementation ViewController

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"CellIdentifier";

    JokeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setJoke:self.array[indexPath.row]];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     //列寬
    CGFloat contentWidth = self.tableView.frame.size.width;
    // 用何種字體進行顯示
    UIFont *font = [UIFont systemFontOfSize:14];
    // 該行要顯示的內容
    Joke *joke = self.array[indexPath.row];
    NSString *content =joke.content;
    // 計算出顯示完內容需要的最小尺寸
    
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize size = [content boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width-2*10, MAXFLOAT) options:  NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    
    NSDictionary *attributeUpdateTIme = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGSize updateTimeSize = [joke.updatetime boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width-2*10, MAXFLOAT) options: NSStringDrawingTruncatesLastVisibleLine attributes:attributeUpdateTIme context:nil].size;
    //NSLog(@"%f %f",size.width,size.height);
    //NSLog(@"%d %@ %f",indexPath.row,content,size.height);
    return size.height+30+updateTimeSize.height ;
    
}

-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[JokeTableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
        
        //设置header下拉刷新
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [self.view addSubview:_tableView];
        self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 0, 0);
        [self.tableView reloadData];
        [self.tableView.mj_header beginRefreshing];

    }
    return _tableView;
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleInsert;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



-(void)loadData{
//    NSString *urlString = @"http://japi.juhe.cn/joke/content/list.from?sort=&page=&pagesize=20&time=1455076771&key=7c42acfe9b119a1fc5f01327c560eed3";
    self.currentTime = [[NSDate date] timeIntervalSince1970];
    self.page = 1;
   NSString *urlString= [NSString stringWithFormat:@"http://japi.juhe.cn/joke/content/list.from?sort=&page=%d&pagesize=20&time=%lld&key=7c42acfe9b119a1fc5f01327c560eed3",self.page++,self.currentTime];
    NSURL *url =[NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
     NSLog(@"%s",__func__);
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if (!error) {
            self.array = [Joke jokes:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            });
        }
    }];
    [dataTask resume];
}
-(void)loadMoreData{
    //1. 加载数据
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        // 刷新表格
//        [self.tableView reloadData];
//        // 拿到当前的上拉刷新控件，结束刷新状态
//        [self.tableView.mj_footer endRefreshing];
//    });
    NSString *urlString= [NSString stringWithFormat:@"http://japi.juhe.cn/joke/content/list.from?sort=&page=%d&pagesize=20&time=%lld&key=7c42acfe9b119a1fc5f01327c560eed3",self.page++,self.currentTime];
    NSURL *url =[NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSLog(@"%s",__func__);
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        if (!error) {
            NSMutableArray *temp = [Joke jokes:data];
            for (Joke * joke in temp) {
                [self.array addObject:joke];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self loadData];
    [self tableView];
   
}



@end
