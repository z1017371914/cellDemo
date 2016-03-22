//
//  WeChat.h
//  微信精选
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeChat : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *firstImg;
@property (nonatomic, copy) NSString *mark;
@property (nonatomic, copy) NSString *url;
- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)WCWithDict:(NSDictionary *)dict;

+ (NSMutableArray *)WCs;

////从json中获取数组函数
+ (NSMutableArray *)WCsWithData:(NSData *)data;
@end
