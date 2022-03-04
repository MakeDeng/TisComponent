#
# Be sure to run `pod lib lint TisComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TisComponent'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TisComponent.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                      这是一个初始版本
                       DESC

  s.homepage         = 'https://github.com/MakeDeng/TisComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dengchaoyun' => 'dengchaoyun@zhaoshang.net' }
  s.source           = { :git => 'https://github.com/MakeDeng/TisComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'TisComponent/Classes/**/*.{h,m,xib}'
  
  s.resource_bundles = {
   'TisComponent' => ['TisComponent/Assets/*']
  }

  # s.public_header_files = 'TisComponent/Classes/TISHeader.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
