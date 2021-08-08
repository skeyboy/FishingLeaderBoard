Pod::Spec.new do |s|
  s.name         = "Home"
  s.version      = "0.0.1"
  s.summary      = "A UIView category that adds Android-style toast notifications to iOS."
  s.homepage     = "https://github.com/scalessec/Toast"
  s.license      = 'MIT'
  s.author       = { "Charles Scalesse" => "scalessec@gmail.com" }
  s.source       = { :git => "", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files = 'Sources/**/*.{h,m,xib,png}'
  s.framework    = 'QuartzCore'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }

  s.dependency 'BootBase/Common'
    s.dependency 'BootBase/UCenter'
  s.dependency 'BootBase/GlobalConfig'
  s.dependency 'SDWebImage'
  s.dependency 'BootTools'
  s.dependency 'BootMapKit'
  s.dependency 'BootApi'
  s.dependency 'MJRefresh'
  s.dependency "GRStarsView"
  s.dependency "JLRoutes"

end
