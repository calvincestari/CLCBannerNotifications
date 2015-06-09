Pod::Spec.new do |s|
  s.name             = "CLCBannerNotifications"
  s.version          = "0.2"
  s.summary          = "A simple way to add banner style notifications to your iOS app."
  s.homepage         = "https://github.com/calvincestari/CLCBannerNotifications"
  s.license          = 'MIT'
  s.author           = { "Calvin Cestari" => "calvin@calvincestari.com" }
  s.source           = { :git => "https://github.com/calvincestari/CLCBannerNotifications.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.frameworks = 'UIKit'

  s.public_header_files = 'Pod/**/*.h'
  s.private_header_files = 'Pod/Classes/Controllers/*.h'
  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'CLCBannerNotifications' => ['Pod/Assets/*.png']
  }
end
