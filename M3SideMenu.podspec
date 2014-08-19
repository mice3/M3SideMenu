#
# Be sure to run `pod lib lint M3SideMenu.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "M3SideMenu"
  s.version          = "0.1.0"
  s.summary          = "light weight side menu, that offers navigation and other useful containers"
  s.description      = <<-DESC
a little Objective C side navigation view, that we created for a certain project.
The view is separated into 3 segments: 
- top: extendable table view with add/remove cell functionalities 
- middle: navigation buttons, the view resizes itself depending on the button count) 
- bottom: custom view template (e.g. profile picture) 
 
Each of the three segments can be disabled/hidden, which will make the others adjust their sizes accordingly
                       DESC
  s.homepage         = "https://github.com/mice3/M3SideMenu"
  s.license          = 'MIT'
  s.author           = { "rok črešnik" => "rok@mice3.it" }
  s.source           = { :git => "https://github.com/mice3/M3SideMenu.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rcresnik'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resources = 'Pod/Assets/*.xib'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
