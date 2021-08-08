Pod::Spec.new do |s|
  s.name         = "BootApi"
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

  s.subspec 'Order' do |order|
    order.source_files = 'Sources/Order/**/*.{h,m}'
  end
  
    s.subspec 'Goods' do |good|
        good.source_files = 'Sources/Goods/**/*.{h,m}'
  end
  
      s.subspec 'Event' do |event|
        event.source_files = 'Sources/Event/**/*.{h,m}'
  end
  
      s.subspec 'User' do |user|
        user.source_files = 'Sources/User/**/*.{h,m}'
            user.dependency   "MJExtension"
  end
  
  s.subspec 'Spot' do |spot|
        spot.source_files = 'Sources/Spot/**/*.{h,m}'
              spot.dependency   "MJExtension"
  end
  
   s.dependency "BootBase/Network"
   s.dependency "BootBase/Model"
      s.dependency "BootBase/GlobalConfig"


end
