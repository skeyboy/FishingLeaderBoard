//
//  SelectView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import "SelectView.h"
#import "MySelButton.h"
#define space 10

@interface SelectView()
//选中按钮
@property (nonatomic,strong)UIButton *selectBtn;

@end

@implementation SelectView

-(instancetype)initWithArr:(NSArray *)titleArr row:(NSString *)row cornerRadius:(float)radius height:(CGFloat)height
{
    self = [super init];
    if(self)
    {
        self.selectedMarkArray = [[NSMutableArray alloc]init];
        //self.backgroundColor = [UIColor redColor];
        _rowNum = row;
        MySelButton *p=nil;
        MySelButton *btn;
        for (int i = 0; i<titleArr.count; i++) {
            int row = i / [_rowNum intValue];
            int loc = i % [_rowNum intValue];
            
            btn = [MySelButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:[NSString stringWithFormat:@"  %@  ",[titleArr objectAtIndex:i]] forState:UIControlStateNormal];
           
            [btn addTarget:self  action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
            btn.tag =i+600;
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            btn.layer.borderWidth =1;
            btn.layer.cornerRadius = radius;
            [self addSubview:btn];
            if(p == nil)
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.mas_left).offset(20);
                    make.width.mas_greaterThanOrEqualTo(50); make.top.equalTo(self.mas_top).offset((height+space)*row);
                    make.height.equalTo(@(height));
                }];
            else
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(p.mas_right).offset(space);
                    make.width.mas_greaterThanOrEqualTo(50); make.top.equalTo(self.mas_top).offset((height+space)*row);
                    make.height.equalTo(@(height));
                }];
            if(loc ==([_rowNum intValue]-1))
            {
                p = nil;
            }else{
                p = btn;
            }
        }
    }
    return self;
}

-(void)setSelectIndex:(NSString *)selectIndex
{
    
    UIButton *btn = [self viewWithTag:([selectIndex intValue]+600)];
    if(self.selectBtn == nil)
    {
        self.selectBtn = btn;
        [self.selectBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        self.selectBtn.backgroundColor = NAVBGCOLOR;
        //        self.selectBtn.layer.borderColor = [UIColor greenColor].CGColor;
    }else if(self.selectBtn!=btn)
    {
        [self.selectBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        self.selectBtn.backgroundColor = WHITECOLOR;
        //        self.selectBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.selectBtn = btn;
        [self.selectBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        self.selectBtn.backgroundColor = NAVBGCOLOR;
        //        self.selectBtn.layer.borderColor = [UIColor greenColor].CGColor;
    }
    
}

-(void)btnClick:(MySelButton *)btn{
    if(self.isNoClick)
    {
        return;
    }
    if(self.isMuli == NO)
    {
        if(self.selectBtn == nil)
        {
            self.selectBtn = btn;
            [self.selectBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            self.selectBtn.backgroundColor = NAVBGCOLOR;
            //        self.selectBtn.layer.borderColor = [UIColor greenColor].CGColor;
        }else if(self.selectBtn!=btn)
        {
            [self.selectBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
            self.selectBtn.backgroundColor = WHITECOLOR;
            //        self.selectBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.selectBtn = btn;
            [self.selectBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            self.selectBtn.backgroundColor = NAVBGCOLOR;
            //        self.selectBtn.layer.borderColor = [UIColor greenColor].CGColor;
        }
        self.selectIndex =[NSString stringWithFormat:@"%ld",btn.tag -600];
        if (self.selectViewCtrolClick) {
            self.selectViewCtrolClick(btn.tag -600);
        }
    }else{
        //多选
        if(btn.isChoosed == YES)
        {
            btn.isChoosed = NO;
            [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
            btn.backgroundColor = WHITECOLOR;
            //            btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [self.selectedMarkArray removeObject:[NSString stringWithFormat:@"%ld",btn.tag -600]];
        }else{
            btn.isChoosed = YES;
            [btn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
            btn.backgroundColor = NAVBGCOLOR;
            //            btn.layer.borderColor = [UIColor greenColor].CGColor;
            [self.selectedMarkArray addObject:[NSString stringWithFormat:@"%ld",btn.tag -600]];
        }
        
        
        
        
    }
    
}


-(void)setMoRenSelectedMarkArray:(NSMutableArray *)selectedMarkArray
{
    for (int i= 0; i<selectedMarkArray.count; i++) {
        int item = [[selectedMarkArray objectAtIndex:i]intValue]+600;
        MySelButton *btn = (MySelButton *)[self viewWithTag:item];
        btn.isChoosed = YES;
        [btn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        btn.backgroundColor = NAVBGCOLOR;
    }
    [self.selectedMarkArray addObjectsFromArray:selectedMarkArray];
    
}
@end
