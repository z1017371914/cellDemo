//
//  JokeTableViewCell.h
//  alerViewController
//
//  Created by apple on 16/2/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Joke;
@interface JokeTableViewCell : UITableViewCell
@property (nonatomic, strong) Joke *joke;
@end
