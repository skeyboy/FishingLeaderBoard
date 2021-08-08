//
//  SaiShiListTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/23.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SaiShiListTableViewCell.h"

@implementation SaiShiListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.layer.cornerRadius=5;
}
-(void)bindValue:(EventSpotGameItem*)gameItem
{
    //    @property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
    //    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    //    @property (weak, nonatomic) IBOutlet ColorLabel *colorLabel1;
    //
    //    @property (weak, nonatomic) IBOutlet ColorLabel *colorLabel2;
    //
    //    @property (weak, nonatomic) IBOutlet ColorLabel *colorLabel3;
    //    @property (weak, nonatomic) IBOutlet UILabel *shangXianLabel;
    //
    //    @property (weak, nonatomic) IBOutlet UILabel *feiYongLabel;
    //    @property (weak, nonatomic) IBOutlet UILabel *dateLabel;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:gameItem.coverImage] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    
    NSDictionary *dict = @{@"normal":@"正钓",@"donkey":@"偷驴",@"positive":@"正场",@"sub":@"副场",@"pick":@"捡漏"};
    NSArray *arr = @[@"日场",@"夜场"];
    //    self.titleLabel.text =[NSString stringWithFormat:@"%@ %@ %@ %@ %@",[dict objectForKey:gameItem.tab],[arr objectAtIndex:gameItem.eventTimes-1],gameItem.fishes,gameItem.spotName,gameItem.name];
    self.titleLabel.text = gameItem.name;
    self.colorLabel1.text = (gameItem.type == 1)?@"活动":@"赛事";
    self.colorLabel2.text = (gameItem.eventTimes ==1)?@"日场":@"夜场";
    self.colorLabel3.text = (gameItem.isPast == 1)?@"已过期":@"报名中";
    self.cityLabel.text = (gameItem.city)?gameItem.city:@"";
    self.shangXianLabel.text = [NSString stringWithFormat:@"上限：%ld人",(long)gameItem.peopleNumber];
    self.feiYongLabel.text = [NSString stringWithFormat:@"费用：%@元/人",gameItem.money];
    self.dateLabel.text = [ToolClass dateToString:gameItem.startTime];
    arr =@[@"排名赛事",@"抽奖赛事",@"普通活动",@"积分活动"];
    if((gameItem.pattern-1)>=0)
    {
        self.jifensaishiLabel.text = [arr objectAtIndex: gameItem.pattern-1];
        self.jifensaishiLabel.textColor = [UIColor redColor];
        self.jifensaishiLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else{
        self.jifensaishiLabel.text = @"";
        self.jifensaishiLabel.backgroundColor = WHITECOLOR;
    }
    
    if(kiPhone5||kiPhone4)
    {
        [self.leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                                make.width.equalTo(@110);
        }];
    }
}

@end
