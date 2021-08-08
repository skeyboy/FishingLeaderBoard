Pod::Spec.new do |s|
  s.name         = "BootTools"
  s.version      = "0.0.1"
  s.summary      = "A UIView category that adds Android-style toast notifications to iOS."
  s.homepage     = "https://github.com/scalessec/Toast"
  s.license      = 'MIT'
  s.author       = { "Charles Scalesse" => "scalessec@gmail.com" }
  s.source       = { :git => "", :tag => s.version.to_s }
  s.platform     = :ios
  s.source_files = 'Sources/**/*.{h,m}'
  s.framework    = 'QuartzCore'
  s.requires_arc = true
  
  s.dependency 'BootBase/Common'
  s.dependency 'BootBase/GlobalConfig'
  s.dependency 'SDWebImage'
  s.dependency 'JZLocationConverter'

  s.dependency 'Masonry'

end
