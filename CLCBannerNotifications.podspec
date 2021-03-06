Pod::Spec.new do |s|
  s.name             = "CLCBannerNotifications"
  s.version          = "0.5"
  s.summary          = "A simple way to add banner style notifications to your iOS app."
  s.homepage         = "https://github.com/calvincestari/CLCBannerNotifications"
  s.license          = 'MIT'
  s.author           = { "Calvin Cestari" => "calvin@calvincestari.com" }
  s.source           = { :git => "https://github.com/calvincestari/CLCBannerNotifications.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.frameworks = 'UIKit'

  s.public_header_files = 'CLCBannerNotifications/**/*.h'
  s.private_header_files = 'CLCBannerNotifications/Classes/Controllers/*.h'
  s.source_files = 'CLCBannerNotifications/Classes/**/*.{h,m}'
end
