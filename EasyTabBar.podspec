Pod::Spec.new do |s|
  s.name                  = 'EasyTabBar'
  s.version               = '0.9.0'
  s.summary               = 'use UITabBar and UITabBarController easily!'

  s.homepage              = 'https://github.com/alflix/EasyNavigationBar'
  s.license               = { :type => 'Apache-2.0', :file => 'LICENSE' }

  s.author                = { 'John' => 'jieyuanz24@gmail.com' }
  s.social_media_url      = 'https://github.com/alflix'

  s.platform              = :ios
  s.ios.deployment_target = '10.0'

  s.source                = { :git => 'https://github.com/alflix/EasyNavigationBar.git', :tag => "#{s.version}" }
  s.ios.framework         = 'UIKit'
  s.source_files          = 'Source/*.swift'

  s.module_name           = 'TabBar'
  s.requires_arc          = true

  s.swift_version         = '5.1'
  s.pod_target_xcconfig   = { 'SWIFT_VERSION' => '5.1' }
  s.static_framework      = true
  
end
