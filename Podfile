# Uncomment the next line to define a global platform for your project
# platform :ios, '8.0'
#source 'https://github.com/CocoaPods/Specs.git'
#source 'https://gitee.com/mirrors/CocoaPods-Specs'
#source 'https://mirrors.tuna.tsinghua.edu.cn/git/CocoaPods/Specs.git'
source 'https://gitee.com/mirrors/CocoaPods-Specs.git'

GitHubs = [
'YYKit',
'SDWebImage',
'Masonry',
'MBProgressHUD',
'MJExtension',
'MJRefresh',
'GRStarsView',
'IQKeyboardManager',
'RITLKit',
'PKYStepper',
'Toast',
'TZImagePickerController',
'JZLocationConverter',
'JTCalendar',
]
LocalPath = "~/Documents/GitHub/"

target 'FishingLeaderBoard' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for FishingLeaderBoard
  
  platform:ios, '9.0'
  
  GitHubs.each do |git|
    
    pod git , :path=>"#{LocalPath}#{git}"
    
  end
  
  pod 'JLRoutes'
#  pod 'AFNetworking'
  pod 'BootBase/Network',:path=>"./FishPod/BootBase"
  pod 'BootBase/UCenter',:path=>"./FishPod/BootBase"
  pod 'BootBase/GlobalConfig',:path=>"./FishPod/BootBase"
  pod 'BootBase/Common',:path=>"./FishPod/BootBase"
  pod 'BootBase/Model',:path=>"./FishPod/BootBase"
  pod 'BootTools',:path=>"./FishPod/BootTools"
#  pod 'BootPay',:path=>"../FishPod/BootPay"
  pod 'BootMapKit',:path=>"./FishPod/BootMapKit"
  pod 'BootApi',:path=>"./FishPod/BootApi"

  
  
  pod 'Home',:path=>"./FishPod/BootComponent/Home"
  pod 'Scan',:path=>"./FishPod/BootComponent/Scan"

  
  
  
#pod 'BootWX' ,:path=>"../FishPod/BootWX"
  pod 'LBXScan',:path=>"#{LocalPath}LBXScan",:subspecs=>['LBXZXing',"UI"]
  pod 'WechatOpenSDK'

  #  pod 'YZXCalendar'
#  pod 'WechatOpenSDK'
#  pod 'UMCCommon'
#  pod 'UMCAnalytics'
#  pod 'UMCCommonLog'
  
  #   pod 'XTCAlipaySDK-iOS',:path=>'~/Documents/Github/XTC_AlipaySDK'
  #   pod 'BaiduMapKit'
  # pod 'AlipaySDK-iOS', '~> 0.0.1'
  pod 'RITLPhotos',:path=>'~/Documents/Github/RITLImagePickerDemo'
# pod 'YCSymbolTracker',:git=>"https://github.com/ryan7cruise/YCSymbolTracker.git"

 
  
  target 'FishingLeaderBoardTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FishingLeaderBoardUITests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  post_install do |installer|
#      require './Pods/YCSymbolTracker/YCSymbolTracker/symbol_tracker.rb'
#      symbol_tracker(installer)
  end

  pre_install do |installer|
    # workaround for https://github.com/CocoaPods/CocoaPods/issues/3289
    Pod::Installer::Xcode::TargetValidator.send(:define_method, :verify_no_static_framework_transitive_dependencies) {}
    end
  
end
