//
//  SelectView.h
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/5.
//  Copyright © 2019 yue. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^SelectViewCtrolClick) (NSInteger);

@interface SelectView : UIView

@property(nonatomic,copy)SelectViewCtrolClick selectViewCtrolClick;
-(void)setMoRenSelectedMarkArray:(NSMutableArray *)selectedMarkArray;
//列数
@property (nonatomic,copy) NSString *rowNum;

//默认选中下标单选使用
@property (nonatomic,copy) NSString *selectIndex;

//数据
@property (nonatomic,strong) NSArray *titleArr;


//是否多选
@property (nonatomic,assign) BOOL isMuli;

@property (nonatomic,assign) BOOL isNoClick;//1:不可点 0可点
//多选
// 选中标签数组(数字)
@property (nonatomic, strong) NSMutableArray *selectedMarkArray;

-(instancetype)initWithArr:(NSArray *)titleArr row:(NSString *)row cornerRadius:(float)radius height:(CGFloat)height;
@end
NS_ASSUME_NONNULL_END

