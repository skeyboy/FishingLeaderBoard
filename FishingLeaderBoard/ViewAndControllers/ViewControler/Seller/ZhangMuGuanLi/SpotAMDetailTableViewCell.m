//
//  SpotAMDetailTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/4/18.
//  Copyright © 2020 yue. All rights reserved.
//

#import "SpotAMDetailTableViewCell.h"

@implementation SpotAMDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)bindData:(OrderEventAllListItem*)item
{
    if(item.managementType == 1)
    {
        [self.typeBtn setTitle:@"放鱼收入" forState:UIControlStateNormal];
        [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"se_fangyushouru"] forState:UIControlStateNormal];
        self.label1.text = [NSString stringWithFormat:@"%@",(!item.tranPrice)?@"":item.tranPrice];
        self.label2.text = [NSString stringWithFormat:@"%@",(!item.tranCount)?@"":item.tranCount];
        self.jinELabel.text = [NSString stringWithFormat:@"%@",(!item.tranAmount)?@"":item.tranAmount];
        self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",[ToolClass dateToString2:item.createTime]];
    }else  if(item.managementType == 2){
           [self.typeBtn setTitle:@"放鱼支出" forState:UIControlStateNormal];
           [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"se_fangyuzhichu"] forState:UIControlStateNormal];
           self.label1.text = [NSString stringWithFormat:@"%@",(!item.tranPrice)?@"":item.tranPrice];
           self.label2.text = [NSString stringWithFormat:@"%@",(!item.tranCount)?@"":item.tranCount];
           self.jinELabel.text = [NSString stringWithFormat:@"%@",(!item.tranAmount)?@"":item.tranAmount];
           self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",[ToolClass dateToString2:item.createTime]];
     }else  if(item.managementType == 3){
              [self.typeBtn setTitle:@"收鱼" forState:UIControlStateNormal];
              [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"se_shouyu1"] forState:UIControlStateNormal];
              self.label1.text = [NSString stringWithFormat:@"%@",(!item.tranPrice)?@"":item.tranPrice];
              self.label2.text = [NSString stringWithFormat:@"%@",(!item.tranCount)?@"":item.tranCount];
              self.jinELabel.text = [NSString stringWithFormat:@"%@",(!item.tranAmount)?@"":item.tranAmount];
              self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",[ToolClass dateToString2:item.createTime]];
       }else  if(item.managementType == 4){
                  [self.typeBtn setTitle:@"鱼票" forState:UIControlStateNormal];
                  [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"se_yupiao"] forState:UIControlStateNormal];
                  self.label1.text = [NSString stringWithFormat:@"%@",(!item.tranPrice)?@"":item.tranPrice];
                  self.label2.text = [NSString stringWithFormat:@"%@",(!item.tranCount)?@"":item.tranCount];
                  self.jinELabel.text = [NSString stringWithFormat:@"%@",(!item.tranAmount)?@"":item.tranAmount];
                  self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",[ToolClass dateToString2:item.createTime]];
           }else  if(item.managementType == 5){
                       [self.typeBtn setTitle:@"其他收入" forState:UIControlStateNormal];
                       [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"se_qita"] forState:UIControlStateNormal];
                       self.label1.text =  [NSString stringWithFormat:@"%@",(!item.remark)?@"":item.remark];
               
                       self.label2.text = @"";
                       self.jinELabel.text = [NSString stringWithFormat:@"%@",(!item.tranAmount)?@"":item.tranAmount];
                       self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",[ToolClass dateToString2:item.createTime]];
            }else  if(item.managementType == 6){
                                [self.typeBtn setTitle:@"其他支出" forState:UIControlStateNormal];
                                [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"se_qita"] forState:UIControlStateNormal];
                self.label1.text = [NSString stringWithFormat:@"%@",(!item.remark)?@"":item.remark];
                                self.label2.text = @"";
                                self.jinELabel.text = [NSString stringWithFormat:@"%@",(!item.tranAmount)?@"":item.tranAmount];
                                self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",[ToolClass dateToString2:item.createTime]];
            }else  if(item.managementType == 7){
                                         [self.typeBtn setTitle:@"标鱼支出" forState:UIControlStateNormal];
                                         [self.typeBtn setBackgroundImage:[UIImage imageNamed:@"se_qita"] forState:UIControlStateNormal];
                                         self.label1.text =  [NSString stringWithFormat:@"%@",(!item.remark)?@"":item.remark];
                                         self.label2.text = @"";
                                         self.jinELabel.text = [NSString stringWithFormat:@"%@",(!item.tranAmount)?@"":item.tranAmount];
                                         self.updateTimeLabel.text = [NSString stringWithFormat:@"更新时间：%@",[ToolClass dateToString2:item.createTime]];
                                  }
    if(item.type==1)//不是自添加
    {
        self.isZiTianJiaLabel.hidden = YES;
    }else{
        self.isZiTianJiaLabel.hidden = NO;

    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
