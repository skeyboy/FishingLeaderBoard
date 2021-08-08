//
//  ReleaseFishGetViewController.m
//  FishingLeaderBoard
//   发渔获
//  Created by yue on 2019/10/29.
//  Copyright © 2019 yue. All rights reserved.
//

#import "ReleaseFishGetViewController.h"
#import "RemovableView.h"
#import "GreenLineTextField.h"
#import "SpotLocationChoseViewController.h"
@interface ReleaseFishGetViewController ()
{
    GreenLineTextField* sayGreenTF;
    UIScrollView *bgScrollView;
    UIView * bgView;
    __block  GreenLineTextField* locationGreenTF;
    __block MySelButton *fengMianTuBtn;

}
@end

@implementation ReleaseFishGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavViewWithTitle:@"发布渔获" isShowBack:YES];
    [self initPageView];
}
-(void)initPageView
{
    bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(hkNavigationView.frame), SCREEN_WIDTH, SCREEN_HEIGHT-Height_NavBar)];
    [self.view addSubview:bgScrollView];
    bgView = [[UIView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - Height_NavBar)];
    [bgScrollView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(bgScrollView);
        make.width.equalTo(bgScrollView);
        make.height.greaterThanOrEqualTo(@300);
    }];
    
    
    __weak __typeof(self) weakSelf = self;
    sayGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:sayGreenTF];
    [sayGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).offset(10);
        make.left.equalTo(bgView.mas_left);
        make.height.equalTo(@300);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    sayGreenTF.leftLabel.hidden = YES;
    sayGreenTF.enterTextField.hidden =YES;
    sayGreenTF.textView.layer.cornerRadius = 5;
    sayGreenTF.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    sayGreenTF.textView.layer.borderWidth = 1;
    sayGreenTF.textView.hidden = NO;
    sayGreenTF.placeHolderLabel.text = @"请输入内容";
    
    fengMianTuBtn =[FViewCreateFactory createCustomButtonWithName:@"" delegate:self selector:@selector(fengmianClick:) tag:0];
    [fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
    fengMianTuBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    fengMianTuBtn.layer.borderWidth = 1;
    [bgView addSubview:fengMianTuBtn];
    [fengMianTuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sayGreenTF.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(20);
        make.height.equalTo(@200);
        make.width.equalTo(@(SCREEN_WIDTH - 40));
    }];
    
    
    
    
    
//    RemovableViewContainer *container = [[RemovableViewContainer alloc]initWithFrame:CGRectMake(40,CGRectGetMaxY(sayGreenTF.frame) ,SCREEN_WIDTH-80, 0) columCount:3];
//    container.imageWidthAndHieight = 75;
//    container.OnAddClicked = ^(RemovableViewContainer *__weak  _Nonnull selfView){
//
//    };
//    UIView * av = [UIView new];
//    [av addSubview:container];
//    [bgView addSubview:av];
//
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(av.mas_left);
//        make.top.equalTo(av.mas_top);
//        make.right.equalTo(av.mas_right);
//        make.bottom.equalTo(av.mas_bottom);
//        make.height.greaterThanOrEqualTo(@120);
//    }];
//    [av mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bgView.mas_left);
//        make.right.equalTo(bgView.mas_right);
//        make.width.equalTo(bgView.mas_width);
//        make.height.greaterThanOrEqualTo(@120);
//        make.top.equalTo(sayGreenTF.mas_bottom);
//    }];
    locationGreenTF = [[[NSBundle mainBundle]loadNibNamed:@"GreenLineTextField" owner:self options:nil]firstObject];
    [bgView addSubview:locationGreenTF];
    locationGreenTF.leftLabel.hidden = YES;
    locationGreenTF.leftImageView.hidden = NO;
    locationGreenTF.enterTextField.text = @"所在位置";
    locationGreenTF.enterTextField.tag = TEXTFIELD_SAISHISHIJIAN_TAG;
    @weakify(self)
    locationGreenTF.textFieldClick = ^(UITextField * textField) {
        [weak_self  locationClick];
    };
    locationGreenTF.enterTextField.enabled = NO;
    [locationGreenTF.rightButton setImage:[UIImage imageNamed:@"rightInto_b"] forState:UIControlStateNormal];
    locationGreenTF.rightButton.hidden = NO;
//    [locationGreenTF.rightButton addTarget:self action:@selector(locationClick) forControlEvents:UIControlEventTouchUpInside];
    [locationGreenTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(fengMianTuBtn.mas_bottom);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.height.greaterThanOrEqualTo(@50);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    UIButton *btn = [FViewCreateFactory createCustomButtonWithName:@"发布" delegate:self selector:@selector(faBu:) tag:0];
    btn.backgroundColor = [UIColor orangeColor];
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(locationGreenTF.mas_bottom).offset(10);
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.equalTo(@(40));
        make.bottom.equalTo(bgView.mas_bottom).offset(-20);
    }];
    btn.layer.cornerRadius = 5;
}
-(void)faBu:(UIButton*)Btn
{
//    "spotId": 0,
//    "coverImage": "string",
//    "content": "string",
//    "address": "string"
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    if(self.spotId!=0)
    {
        [dict setValue:@(self.spotId) forKey:@"spotId"];
    }
    [dict setValue:fengMianTuBtn.str forKey:@"coverImage"];
    [dict setValue:sayGreenTF.textView.text forKey:@"content"];
    [dict setValue:locationGreenTF.enterTextField.text forKey:@"address"];
    [[ApiFetch share]infoPostFetch:INFO_FISHGET body:dict holder:self dataModel:NSDictionary.class onSuccess:^(NSObject * _Nonnull modelValue, id  _Nonnull response) {
        [self addAlert];
    }];
}
-(void)addAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"发布成功" message:@"" preferredStyle:UIAlertControllerStyleAlert];
       
         UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             self.faBuSuccessBlock();
            [self.navigationController popViewControllerAnimated:YES];
  
         }];
        [alert addAction:sure];
        [self presentViewController:alert animated:YES completion:^{
        }];
}
-(void)locationClick
{
    SpotLocationChoseViewController * spotLocationChoseVc = [[SpotLocationChoseViewController alloc] init];
     spotLocationChoseVc.reverLocationResult = ^(NSString * _Nonnull address, CLLocationCoordinate2D coordinate  ,NSString *cityId) {
         self->locationGreenTF.enterTextField.text = address;
     };
     
     [self.navigationController pushViewController:spotLocationChoseVc
                                          animated:YES];
}

-(void)fengmianClick:(MySelButton *)btn
{
    if (btn.isChoosed == YES) {
        return;
    }
    JJImagePicker *picker = [ToolView selectImageFromAlbum];
          [picker actionSheetWithTakePhotoTitle:@"" albumTitle:@"从相册选择一张图片" cancelTitle:@"取消" InViewController:self didFinished:^(JJImagePicker *picker, UIImage *image) {
              [[ApiFetch share]upload:image success:^(NSString *msg) {
                  [self hideHud];
                  btn.isChoosed = YES;
                  btn.str=msg;
                  [btn setImage:image forState:UIControlStateNormal];
                  //添加删除按钮
                  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self->fengMianTuBtn.frame)-10, CGRectGetMinY(self->fengMianTuBtn.frame)-10, 20, 20)];
                    imageView.image = [UIImage imageNamed:@"delete.png"];
                    [bgView addSubview:imageView];
                    imageView.userInteractionEnabled = YES;
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
                        UITapGestureRecognizer *t = (UITapGestureRecognizer*)sender;
                        [self->fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
                        [t.view removeFromSuperview];
                        self->fengMianTuBtn.isChoosed = NO;
                        self->fengMianTuBtn.str = @"";
                    }];
                    [imageView addGestureRecognizer:tap];
              } failure:^{
                  [self hideHud];
              }];
          }];
}
- (void)photosViewController:(UIViewController *)viewController thumbnailImages:(NSArray<UIImage *> *)thumbnailImages infos:(NSArray<NSDictionary *> *)infos
{
    for (UIImage * thumbnailImage in thumbnailImages) {
        
        fengMianTuBtn.imageView.image = thumbnailImage;
        [fengMianTuBtn setImage:thumbnailImage forState:UIControlStateNormal];
    }
    
    //添加删除按钮
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-20-15, CGRectGetMinY(fengMianTuBtn.frame)-15, 30, 30)];
    imageView.image = [UIImage imageNamed:@"delete.png"];
    [self.view addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
        UITapGestureRecognizer *t = (UITapGestureRecognizer*)sender;
        [self->fengMianTuBtn setImage:[UIImage imageNamed:@"Image_Add"] forState:UIControlStateNormal];
        [t.view removeFromSuperview];
    }];
    [imageView addGestureRecognizer:tap];
}
@end
