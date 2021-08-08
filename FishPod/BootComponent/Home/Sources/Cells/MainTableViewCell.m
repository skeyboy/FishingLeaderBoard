//
//  MainTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MainTableViewCell.h"
#import "InfoNewHot.h"
#import<SDWebImage/SDWebImage.h>
#import "ToolClass.h"
@implementation MainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bind:(NSArray *)arrTableSource indexPath:(NSIndexPath*) indexPath
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //    self.imageView1.image = [UIImage imageNamed:@"page1"];
    //    //self.imageView2.image = [UIImage imageNamed:@"page1"];
    //    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:@"http://www.51pptmoban.com/d/file/2014/01/20/e382d9ad5fe92e73a5defa7b47981e07.jpg"] placeholderImage:nil];
    //
    //    self.imageView3.image = [UIImage imageNamed:@"page1"];
    //    self.detailTimeLabel.text = @"19/19月05日 17：16";
    NewHot *newHot = [arrTableSource objectAtIndex:indexPath.row];
    self.titleTextLabel.text = newHot.title;
    [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:[newHot.images objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:[newHot.images objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    if(newHot.images.count>=3)
    {
    [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:[newHot.images objectAtIndex:2]] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    }
    self.detailTimeLabel.text = [ToolClass dateToString:newHot.createTime];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
