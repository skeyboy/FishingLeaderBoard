//
//  FaBuPingJiaView.m
//  FishingLeaderBoard
//
//  Created by yue on 2020/2/12.
//  Copyright © 2020 yue. All rights reserved.
//

#import "FaBuPingJiaView.h"
@implementation FaBuPingJiaView
-(instancetype)init
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"FaBuPingJiaView" owner:self options:nil] lastObject];
    if (self) {
        self.starsView = [self addstars];
        [self addBiaoQian];
        [self.pingjiaLeftLabel setRedStarText:@"*评价"];
        [self.pingjiabiaoqianLeftLabel setRedStarText:@"*评价标签(至少选择一个)"];
    }
    return self;
}
-(GRStarsView *)addstars{
    _starsView = [[GRStarsView alloc] initWithStarSize:CGSizeMake(30, 30) margin:0 numberOfStars:5];
    _starsView.frame = CGRectMake(0, 0, 160,40);
    [self.bgStarView addSubview:_starsView];
    _starsView.allowSelect = YES;  // 默认可点击
    _starsView.allowDecimal = YES;  //默认可显示小数
    _starsView.allowDragSelect =YES;//默认不可拖动评分，可拖动下需可点击才有效
    _starsView.score = 0;
    _starsView.touchedActionBlock = ^(CGFloat score) {
        
    };
    return _starsView;
}
-(void)addBiaoQian{
    self.slView = [[SelectView alloc]initWithArr:@[@"环境干净",@"老版热情",@"钓位宽大",@"车位充足",@"餐位服务周到",@"实数放鱼",@"钓场清净"] row:@"4" cornerRadius:3 height:40];
    [self.bgBiaoQianView addSubview:self.slView];
    self.slView.isMuli = YES;//多选
    //    slView.selectIndex = @"0";
    [self.slView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgBiaoQianView.mas_top);
        make.centerX.equalTo(self.bgBiaoQianView.mas_centerX);
        make.width.equalTo(self.bgBiaoQianView.mas_width);
        make.height.equalTo(self.bgBiaoQianView.mas_height);
    }];
}
- (IBAction)cancelAction:(id)sender {
    [self removeFromSuperview];
    
}
- (IBAction)tijiaoAction:(id)sender {
    
}
@end
