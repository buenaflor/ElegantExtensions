#
# Be sure to run `pod lib lint ElegantExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ElegantExtensions'
  s.version          = '0.1.0'
  s.summary          = 'ElegantExtensions is a collection of useful extensions'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Make coding easier & more clear with ElegantExtensions. AutoLayout has never been so easy, TableViews & CollectionViews are more flexible than ever.
                       DESC

  s.homepage         = 'https://github.com/buenaflor/ElegantExtensions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Giancarlo Buenaflor' => 'giancarlo.buenaflor@yahoo.com' }
  s.source           = { :git => 'https://github.com/buenaflor/ElegantExtensions.git', :tag => s.version.to_s }
  s.swift_version = '4.1'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = '*.swift'
  
  # s.resource_bundles = {
  #   'ElegantExtensions' => ['ElegantExtensions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
