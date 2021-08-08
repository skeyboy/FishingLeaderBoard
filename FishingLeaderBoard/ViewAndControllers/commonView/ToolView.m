//
//  LunBoView.m
//  FishingLeaderBoard
//
//  Created by yue on 2019/11/14.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ToolView.h"
#import "FImagePageViewCellCollectionViewCell.h"
#import "WMZBannerView.h"


@implementation ToolView

+(void)getLunBoViewHeight:(float)height width:(float)width y:(float)y x:(float)x superView:(UIView *)superView data:(NSArray *)dataArr clickBlock:(BannerClickBlock)click
{
    NSLog(@"bannnedata = %@,%lf,%lf",dataArr,height,width);
    WMZBannerParam *param =
    BannerParam()
    //自定义视图必传
    .wMyCellClassNameSet(@"FImagePageViewCellCollectionViewCell")
    .wMyCellSet(^UICollectionViewCell *(NSIndexPath *indexPath, UICollectionView *collectionView, id model, UIImageView *bgImageView,NSArray*dataArr) {
        //自定义视图
        WMBannerCellModel *bannerModel = [dataArr objectAtIndex:indexPath.row];
        FImagePageViewCellCollectionViewCell *cell = (FImagePageViewCellCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FImagePageViewCellCollectionViewCell class]) forIndexPath:indexPath];
      
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:bannerModel.imageName] placeholderImage:[UIImage imageNamed:@"Image_placeHolder"]];
        cell.icon.layer.cornerRadius = 5;
        cell.icon.clipsToBounds = YES;
        cell.leftText.text = bannerModel.leftStr;
        
        return cell;
    })
    .wEventClickSet(^(id anyID, NSInteger index) {
        NSLog(@"点击 %@ %ld",anyID,index);
        // type1：钓场，2：活动，3：赛事，4：文章
        click(anyID,index);
    })
    .wFrameSet(CGRectMake(x, y,width, height))
    .wImageFillSet(YES)
    .wLineSpacingSet(0)
    .wScaleSet(NO)
    .wItemSizeSet(CGSizeMake(width, height))
    .wAutoScrollSecondSet(3)
    .wAutoScrollSet(YES)
    .wSelectIndexSet(0)
    .wPositionSet(BannerCellPositionCenter)
    .wBannerControlSelectColorSet([UIColor whiteColor])
    .wBannerControlColorSet(BLACKGRAY)
    .wBannerControlImageRadiusSet(5)
    .wHideBannerControlSet(NO)
    .wBannerControlPositionSet(BannerControlCenter)
    .wDataSet(dataArr)
    .wRepeatSet((dataArr.count == 1)?NO:YES)
    ;
   [[WMZBannerView alloc]initConfigureWithModel:param withView:superView];
}

+(LPButton *)btnTitle:(NSString *)title image:(NSString *)imageStr tag:(int)tag superView:(UIView *)superView sel:(SEL)sel targer:(id)targer setStyle:(LPButtonStyle)style font:(int)font
{
    LPButton *btn  = [[LPButton alloc] init];
    btn.style = style;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    if(sel)
    {
    [btn addTarget:targer action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    btn.tag = tag;
    [superView addSubview:btn];
    return btn;
}


+(UIView*)jiFenShowView:(int)lianX all:(NSArray*)allArr superView:(UIView*)superView
{
    UIView *view = [FViewCreateFactory createViewWithBgColor:WHITECOLOR];
    [superView addSubview:view];
    UIView *line =[FViewCreateFactory createViewWithBgColor:[UIColor lightGrayColor]];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1);
        make.centerY.equalTo(view.mas_centerY);
        make.left.equalTo(view.mas_left).offset(20);
        make.right.equalTo(view.mas_right).offset(-20);
    }];
    float width = (SCREEN_WIDTH - 70)/10.0;
    if(width>30)
    {
        width = 30;
    }
    NSMutableArray *mArr = [[NSMutableArray alloc]initWithCapacity:10];
    for(int i=0;i<allArr.count;i++)
    {
        UILabel *label =[FViewCreateFactory createLabelWithName:[allArr objectAtIndex:i] font:[UIFont systemFontOfSize:15] textColor:WHITECOLOR];
         if(i<lianX)
         {
            label.backgroundColor = NAVBGCOLOR;
         }else{
            label.backgroundColor = [UIColor lightGrayColor];
         }
        [view addSubview:label];
        [mArr addObject:label];
        label.layer.cornerRadius= width/2.0;
        label.clipsToBounds = YES;
    }
    
    [mArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:width leadSpacing:10 tailSpacing:10];
    [mArr mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerY.equalTo(view.mas_centerY);
        make.height.equalTo(@(width));
    }];
//    for(int i = 0; i<qianArr.count;i++)
//    {
//        NSString *s = [qianArr objectAtIndex:i];
//        for(int j = 0;j<allArr.count;j++)
//        {
//            NSString *l =[allArr objectAtIndex:j];
//            if([l isEqualToString:s] )
//            {
//                UILabel *label = [mArr objectAtIndex:j];
//                label.backgroundColor = [UIColor greenColor];
//                break;
//            }
//        }
//    }
    return view;
}

+(UIView *)addShadowRadius:(UIView *)view
{
    view.layer.shadowOffset =CGSizeMake(0,0);
    view.layer.shadowColor =[UIColor blackColor].CGColor;
    view.layer.shadowOpacity = 0.3;
    view.layer.shadowRadius = 5;
    return view;
}

+(JJImagePicker *)selectImageFromAlbum{
    JJImagePicker *picker = [JJImagePicker sharedInstance];
          //自定义裁剪图片的ViewController
          picker.customCropViewController = ^TOCropViewController *(UIImage *image) {
              
              if (picker.type == JJImagePickerTypePhoto) {
                  //使用默认
                  return nil;
              }
              
            TOCropViewController  *cropController = [[TOCropViewController alloc] initWithImage:image];
              
              //选择框可以按比例来手动调节
              cropController.aspectRatioLockEnabled = YES;
              cropController.resetAspectRatioEnabled = YES;
               //设置选择宽比例
              cropController.aspectRatioPreset = TOCropViewControllerAspectRatioPresetSquare;
              //显示选择框比例的按钮
//              cropController.aspectRatioPickerButtonHidden = NO;
              //显示选择按钮
//              cropController.rotateButtonsHidden = NO;
              //设置选择框可以手动移动
              cropController.cropView.cropBoxResizeEnabled = YES;
              cropController.imageCropFrame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
              return cropController;
          };
          picker.albumText = @"";
          picker.cancelText =@"取消";
          picker.doneText = @"完成";
          picker.retakeText =@"";
          picker.choosePhotoText = @"";
          picker.automaticText = @"";
          picker.closeText = @"关闭";
          picker.openText = @"打开";
    return picker;
}
@end

@implementation WMBannerCellModel


@end 
