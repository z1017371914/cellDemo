//
//  Joke.m
//  alerViewController
//
//  Created by apple on 16/2/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "Joke.h"
@interface Joke ()

@property (nonatomic, strong) NSArray *jokes;


@end
@implementation Joke



+(void)loadData{
    
}
+(NSMutableArray *)jokes:(NSData *)data{
 
    NSDictionary *xiaohua= [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSDictionary *result = xiaohua[@"result"];
    NSArray *sss = (NSArray *)result[@"data"];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in  sss) {
        [arrayM addObject:[self jokeWithDict:dict]];
    }
    
    return arrayM;
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)jokeWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
