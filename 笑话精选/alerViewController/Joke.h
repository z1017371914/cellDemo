//
//  Joke.h
//  alerViewController
//
//  Created by apple on 16/2/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Joke : NSObject
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *hashId;
@property (nonatomic, strong) NSString *unixtime;
@property (nonatomic, strong) NSString *updatetime;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)jokeWithDict:(NSDictionary *)dict;
+ (void)loadData;
/** 返回所有题目数组 */
+ (NSMutableArray *)jokes:(NSData *)data;
@end
