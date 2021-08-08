Pod::Spec.new do |s|
  s.name         = "BootPay"
  s.version      = "0.0.1"
  s.summary      = "A UIView category that adds Android-style toast notifications to iOS."
  s.homepage     = "https://github.com/scalessec/Toast"
  s.license      = 'MIT'
  s.author       = { "Charles Scalesse" => "scalessec@gmail.com" }
  s.source       = { :git => "", :tag => s.version.to_s }
  s.platform     = :ios
  s.framework    = 'QuartzCore'
  s.requires_arc = true
    s.source_files = 'Sources/Pay/**/*.{h,m}'

  s.vendored_frameworks = 'Sources/AlipaySDK.framework'
  s.resources = "Sources/AlipaySDK.bundle"

  s.frameworks = "SystemConfiguration", "CoreTelephony", "QuartzCore", "CoreText", "CoreGraphics", "UIKit", "Foundation","Security","WebKit"
  s.libraries = "z", "c++"
  s.vendored_libraries = 'Sources/WX/libWeChatSDK.a'
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.dependency 'BootBase/Common'
    s.dependency 'BootBase/Network'
  s.dependency 'BootBase/GlobalConfig'
  #s.dependency 'JZLocationConverter'
  s.dependency 'BootApi'
    s.dependency 'YYKit'
    s.dependency  'BootWX'
    s.dependency   'MBProgressHUD'


  

end
