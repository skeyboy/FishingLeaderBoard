//
//  MainNoTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/20.
//  Copyright © 2019 yue. All rights reserved.
//

#import "MainNoTableViewCell.h"
#import "InfoNewHot.h"
#import "ToolClass.h"
@implementation MainNoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bind:(NSArray *) arrTableSource indexPath:(NSIndexPath*) indexPath
{
       NewHot *newHot = [arrTableSource objectAtIndex:indexPath.row];
       self.titleLabel.text = newHot.title;
       self.dateLabel.text = [ToolClass dateToString:newHot.createTime];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
