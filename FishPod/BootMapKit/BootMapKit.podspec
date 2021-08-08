Pod::Spec.new do |s|
  s.name         = "BootMapKit"
  s.version      = "0.0.1"
  s.summary      = "A UIView category that adds Android-style toast notifications to iOS."
  s.homepage     = "https://github.com/scalessec/Toast"
  s.license      = 'MIT'
  s.author       = { "Charles Scalesse" => "scalessec@gmail.com" }
  s.source       = { :git => "", :tag => s.version.to_s }
  s.platform     = :ios
  s.requires_arc = true
  s.frameworks = "CoreLocation", "QuartzCore", "OpenGLES", "SystemConfiguration", "CoreGraphics", "Security", "Foundation", "CFNetwork", "CoreMotion"
  s.source_files = 'Sources/Category/**/*.{h,m,xib,png}'

  s.libraries = "z", "c++"
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }

  s.vendored_frameworks = 'Sources/*.framework'


end
