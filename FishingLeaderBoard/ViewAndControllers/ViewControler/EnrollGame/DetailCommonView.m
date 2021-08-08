//
//  DetailCommonView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/15.
//  Copyright © 2019 yue. All rights reserved.
//

#import "DetailCommonView.h"
@interface DetailCommonView()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation DetailCommonView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self =  [[[NSBundle mainBundle]loadNibNamed:@"DetailCommonView" owner:self options:nil]firstObject];
    if(self)
    {
        self.detailView.delegate = self;
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)coder{
    if (self = [super initWithCoder:coder]) {
    
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    if (self.detailContent.length) {
        self.detailView.text = self.detailContent;
    }
}
-(void)setDetailContent:(NSString *)detailContent{
    _detailContent = detailContent;
    self.detailView.font = [UIFont systemFontOfSize:17];
    self.detailView.text = _detailContent;
    CGSize sizeThatShouldFitTheContent = [self.detailView sizeThatFits:self.detailView.frame.size];
    self.height = sizeThatShouldFitTheContent.height+70;
    self.height= self.height+70;
 }

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}
@end
