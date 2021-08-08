Pod::Spec.new do |s|
  s.name         = "BootBase"
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

  s.subspec 'Network' do |nw|
    nw.source_files = 'Sources/NetRequest/**/*.{h,m}'
        nw.dependency "BootBase/GlobalConfig"
                nw.dependency "BootBase/UCenter"
                nw.dependency "BootBase/Common"

        nw.ios.dependency "AFNetworking"
            nw.dependency 'YYKit'
                      nw.dependency   "MBProgressHUD"
                      nw.dependency   "Toast"
  end
  
    s.subspec 'Common' do |com|
        com.source_files = 'Sources/Common/**/*.{h,m}'
                com.dependency "BootBase/GlobalConfig"
                com.dependency "Masonry"
  end
  
    s.subspec 'UCenter' do |uc|
    uc.source_files = 'Sources/UCenter/**/*.{h,m}'
        uc.dependency "BootBase/GlobalConfig"

  end
  
    s.subspec 'GlobalConfig' do |gc|
    gc.source_files = 'Sources/GlobalConfig/**/*.{h,m}'
    gc.dependency 'YYKit'

  end
    
    s.subspec 'Model' do |md|
      md.source_files = 'Sources/Model/**/*.{h,m}'
    md.dependency 'YYKit'

  end
    
    

  #s.dependency "AFNetworking"
   # s.dependency "YYKit"

end
