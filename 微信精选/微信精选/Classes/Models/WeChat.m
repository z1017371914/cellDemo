//
//  WeChat.m
//  微信精选
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WeChat.h"
static int pno = 1;
static int ps = 20;
static NSString *dtype = @"json";
static NSString *AppKey = @"d17276b3022746fe55fd60eb9b842e26";
@implementation WeChat
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [self init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)WCWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

///获得数据函数
+ (NSMutableArray *)WCs{
     NSMutableArray *arrayM = [NSMutableArray array];
//     NSString *urlString= [NSString stringWithFormat:@"http://v.juhe.cn/weixin/query?pno=%d&ps=%d&dtype=%@&key=%@",pno++,ps,dtype,AppKey];
//    NSURL *url =[NSURL URLWithString:urlString];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    NSURLSession *session = [NSURLSession sharedSession];
//    NSLog(@"%s",__func__);
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
//        if (!error) {
//            self.array = [Joke jokes:data];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.tableView reloadData];
//                [self.tableView.mj_header endRefreshing];
//            });
//        }
//    }];
//    [dataTask resume];

     return arrayM;
}

+(NSMutableArray *)WCsWithData:(NSData *)data{
    NSDictionary *WCs= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *result = WCs[@"result"];
    NSArray *lists = (NSArray *)result[@"list"];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in  lists) {
        [arrayM addObject:[self WCWithDict:dict]];
    }
    
    return arrayM;

}
@end
