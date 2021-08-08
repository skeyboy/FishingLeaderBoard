//
//  MainOneTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/19.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MainOneTableViewCell.h"
#import "InfoNewHot.h"
#import "FConstont.h"
#import "SDWebImage.h"
#import "ToolClass.h"
@implementation MainOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bind:(NSArray *)arrTableSource indexPath:(NSIndexPath *)indexPath{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    NewHot *newHot = [arrTableSource objectAtIndex:indexPath.row];
    self.titleTextLabel.text = newHot.title;
    IMAGE_LOAD(self.imageView1, [newHot.images objectAtIndex:0])

    self.timeLabel.text = [ToolClass dateToString:newHot.createTime];
}

@end
