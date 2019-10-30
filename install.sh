#!/bin/bash
dests=(
'https://github.com/shenlujia/iOS-AlipaySDK.git'
 'https://github.com/shenlujia/iOS-AlipaySDK.git'
     'https://github.com/RITL/RITLImagePickerDemo.git'
       'https://github.com/RITL/RITLKit.git'
       'https://github.com/xtcmoons/XTC_AlipaySDK.git'
        'https://github.com/ibireme/YYKit.git'
        'https://github.com/SDWebImage/SDWebImage.git'
        'https://github.com/SnapKit/Masonry.git'
        'https://github.com/jdg/MBProgressHUD.git'
        'https://github.com/AFNetworking/AFNetworking.git'
        'https://github.com/CoderMJLee/MJExtension.git'
        'https://github.com/CoderMJLee/MJRefresh.git'
        'https://github.com/MxABC/LBXScan.git'
        'https://github.com/MontakOleg/WechatOpenSDK.git'
        )

function clone_all(){
 cd ~/Documents/GitHub
  arr=$1
 
  for i in ${arr[*]}; do
    git clone  $i
  done
 
}
 
 
clone_all "${dests[*]}"
