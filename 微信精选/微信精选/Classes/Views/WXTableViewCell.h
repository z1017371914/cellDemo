//
//  WXTableViewCell.h
//  微信精选
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeChat.h"
@interface WXTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labSource;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UIImageView *firstImage;


@property (nonatomic, strong) WeChat *wc;
/** 提供一个类方法，可以快速创建 Cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
