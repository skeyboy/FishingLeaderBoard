//
//  SellerTableCell.m
//  FishingLeaderBoard
//
//  Created by sk on 2019/11/24.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SellerTableCell.h"
#import "EnrollGameNewViewController.h"
//#import "H5ArticalDetailViewController.h"
@interface SellerTableCell()
{
    SpotEventUserItem * eventItem;
}
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *gameTitleView;
@property (weak, nonatomic) IBOutlet UILabel *gameTimeView;
@property (weak, nonatomic) IBOutlet UILabel *spotPositionView;
@property (weak, nonatomic) IBOutlet ColorLabel *gameTypeView;
@property (weak, nonatomic) IBOutlet UIView *bgSpotView;

@end
@implementation SellerTableCell

/**
 
 商家首页下面的活动/赛事列表，点活动活动/赛事图标进活动/赛事详情，点右下角的报名详情进报告详情页
 */
- (IBAction)toGameDetail:(id)sender {
    EnrollGameNewViewController * detailVC = [[EnrollGameNewViewController alloc] init];
    detailVC.eventId = eventItem.id;
    detailVC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:detailVC
                                                        animated:YES];
}
//跳转报名详情页
- (IBAction)toBaoMingPage:(id)sender {
    H5ArticalDetailViewController * h5VC = [[H5ArticalDetailViewController alloc] init];
    h5VC.url = BUSSINESS_ACTIVEDETAILS(eventItem.id);
    h5VC.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:h5VC
                                                        animated:YES];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.coverImageView.layer.cornerRadius = 5;
      [self.bgSpotView addShadowCornerRadius:3 cornerRadius:5 shadowOpacity:0.2];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)bindValue:(SpotEventUserItem*)value{
    eventItem = value;
//    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:value.converImage] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    IMAGE_LOAD(self.coverImageView, value.coverImage)
    switch (value.type) {
        case 1:
            self.gameTypeView.text = @"活动";
            break;
            case 2:
            self.gameTypeView.text = @"赛事";

            break;
        default:
            break;
    }
    self.gameTitleView.text= value.name;
    self.gameTimeView.text  =[NSString stringWithFormat:@"开始时间：%@", [ToolClass dateToString1:value.startTime]];
    self.spotPositionView.text = [NSString stringWithFormat:@"钓位：%ld/%ld",value.enrollCount,value.peopleNumber];
}

@end
