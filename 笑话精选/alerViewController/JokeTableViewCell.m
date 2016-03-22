//
//  JokeTableViewCell.m
//  alerViewController
//
//  Created by apple on 16/2/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "JokeTableViewCell.h"
#import "Joke.h"
/** 正文字体 */
#define kTextFont   [UIFont systemFontOfSize:14]
@interface JokeTableViewCell()
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *updatetimeLabel;


@end

@implementation JokeTableViewCell
- (UILabel *)contentLabel{
    if (_contentLabel==nil) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = kTextFont;
        _contentLabel.textColor = [UIColor redColor];
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (UILabel *)updatetimeLabel{
    if (_updatetimeLabel == nil) {
        _updatetimeLabel = [[UILabel alloc] init];
        _updatetimeLabel.font = [UIFont systemFontOfSize:12];
        _updatetimeLabel.textColor = [UIColor grayColor];
        [self addSubview:_updatetimeLabel];
    }
    return _updatetimeLabel;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setJoke:(Joke *)joke{
    _joke = joke;
    [self contentLabel];
    [self updatetimeLabel];
    //1.设置内容
    _contentLabel.text = _joke.content;
    _updatetimeLabel.text = _joke.updatetime;
    //2.设置位置
    CGFloat padding =10;
    CGFloat contentX = padding;
    CGFloat contentY = padding;
    CGFloat contentW = [[UIScreen mainScreen] bounds].size.width - 2*padding;
    NSDictionary *attribute = @{NSFontAttributeName: kTextFont};
    CGSize size = [_joke.content boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    CGFloat contentH = size.height;
    
    _contentLabel.frame = CGRectMake(contentX, contentY, contentW, contentH);
    _contentLabel.backgroundColor = [UIColor yellowColor];
    //NSLog(@"%d",size.height);
    
    CGFloat updatetimeX = padding;
    CGFloat updatetimeY = CGRectGetMaxY(_contentLabel.frame) + padding;
    CGFloat updatetimeW = 300;
    CGFloat updatetimeH = 20;
    _updatetimeLabel.frame = CGRectMake(updatetimeX, updatetimeY, updatetimeW, updatetimeH);
    
}

@end
