# Uncomment the next line to define a global platform for your project
# platform :ios, '8.0'
GitHubs = [
  'YYKit',
  'SDWebImage',
  'Masonry',
  'MBProgressHUD',
  'AFNetworking',
'MJExtension',
'MJRefresh',
'GRStarsView',
'LBXScan',
'IQKeyboardManager',
'RITLKit',
]
LocalPath = "~/Documents/Github/"
target 'FishingLeaderBoard' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FishingLeaderBoard

   platform:ios, '8.0'
   
   GitHubs.each do |git|
     
     pod git , :path=>"#{LocalPath}#{git}"
    
   end
  
   pod 'WechatOpenSDK'
 
   pod 'XTCAlipaySDK-iOS',:path=>'~/Documents/Github/XTC_AlipaySDK'
#   pod 'BaiduMapKit'
 
   pod 'RITLPhotos',:path=>'~/Documents/Github/RITLImagePickerDemo'
  target 'FishingLeaderBoardTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FishingLeaderBoardUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
