//
//  WXTableViewCell.m
//  微信精选
//
//  Created by apple on 16/3/21.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "WXTableViewCell.h"
#import <UIImageView+WebCache.h>
@implementation WXTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    // 1. 可重用标示符
    static NSString *ID = @"Cell";
    // 2. tableView查询可重用Cell
    WXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 3. 如果没有可重用cell
    if (cell == nil) {
        NSLog(@"加载XIB");
        // 从XIB加载自定义视图
        cell = [[[NSBundle mainBundle] loadNibNamed:@"WXTableViewCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setWc:(WeChat *)wc{
    self.labTitle.text = wc.title;
    self.labSource.text = wc.source;
    NSString *time = [wc.id substringWithRange:NSMakeRange(7, 8)];
    self.labTime.text = time;
    NSURL *url = [NSURL URLWithString:wc.firstImg];
    NSLog(@"%@",wc.firstImg);
    [self.firstImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder.jpg"]];
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
