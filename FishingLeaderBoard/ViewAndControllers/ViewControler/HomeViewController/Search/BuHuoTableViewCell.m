//
//  BuHuoTableViewCell.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/10/21.
//  Copyright © 2019 yue. All rights reserved.
//

#import "BuHuoTableViewCell.h"
#import "InfoFishCatchItem.h"
#import "FishingLeaderBoard-Swift.h"
@implementation BuHuoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.button1.layer.borderColor = WHITEGRAY.CGColor;
    self.button2.layer.borderColor = WHITEGRAY.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (IBAction)btn1Click:(CellButton*)btn {
    
    [self pushToDetail:self.item1];

}

- (IBAction)btn2Click:(id)sender {
    [self pushToDetail:self.item2];
}
-(void)pushToDetail:(InfoFishCatchItem *) item{
    
    
      H5ArticalDetailViewController *h5Vc = [[H5ArticalDetailViewController alloc] init];
    h5Vc.url = FISH_CATCH(item.id);
    h5Vc.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:h5Vc
                                                        animated:YES];
      
}
-(void)bindValue:(InfoFishCatchItem*)item1 Value2:(InfoFishCatchItem*)item2
{
    self.item1 = item1;
    self.item2 = item2;
    //    PropAssign(NSInteger, id)
    //    PropAssign(NSInteger, userId)
    //    PropCopy(NSString, title)
    //    PropCopy(NSString, userNickName)
    //    PropCopy(NSString, userHeadImg)
    //    PropAssign(NSInteger, spotId)
    //    PropCopy(NSString, spotName)
    //    PropCopy(NSString, coverImage)
    //    PropCopy(NSString, images)
    //    PropAssign(NSInteger, likeCount)
    //    PropCopy(NSDate, createTime)
    //    PropCopy(NSDate, updateTime)
    //    PropCopy(NSString, content)
    [self.ImageView1 sd_setImageWithURL:[NSURL URLWithString:item1.coverImage]  placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
    self.contentLabel1.text = item1.title;
    [self.userButton1 sd_setImageWithURL:[NSURL URLWithString:item1.userHeadImg]forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"user_my"] ];
    self.userNameLabel1.text = item1.userNickName;
    self.countLabel1.text = [NSString stringWithFormat:@"%ld", item1.likeCount];
    
    if(item2 == nil)
    {
        self.button2.hidden = YES;
        self.imageView2.hidden = YES;
        self.userButton2.hidden = YES;
        self.userNameLabel2.hidden = YES;
        self.countLabel2.hidden = YES;
        self.contentLabel2.hidden = YES;
        self.zanImageView2.hidden = YES;
    }else{
        self.button2.hidden = NO;
        self.imageView2.hidden = NO;
        self.userButton2.hidden = NO;
        self.userNameLabel2.hidden = NO;
        self.countLabel2.hidden = NO;
        self.contentLabel2.hidden = NO;
        self.zanImageView2.hidden = NO;
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:item2.coverImage]  placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
        self.contentLabel2.text = item2.title;
        [self.userButton2 sd_setImageWithURL:[NSURL URLWithString:item2.userHeadImg] forState:UIControlStateNormal];
        self.userNameLabel2.text = item2.userNickName;
        self.countLabel2.text = [NSString stringWithFormat:@"%ld", (long)item2.likeCount];
        
    }
    
    
    
}
@end
