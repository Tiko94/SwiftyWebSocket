#
#  Be sure to run `pod spec lint SwiftyWebSocket.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = 'SwiftyWebSocket'
  spec.version      = '1.0'
  spec.license      = 'MIT'
  spec.homepage     = 'https://github.com/Tiko94/SwiftyWebSocket'
  spec.authors      = { 'Tigran Mirijanyan' => 'mirijanyant@gmail.com' }
  spec.summary      = 'WebSocket framework for Swift'
  spec.source_files = 'SwiftyWebSocket'
  spec.swift_version = '5.0'
  spec.ios.deployment_target  = '13.0'
  spec.source = {:git => "https://github.com/Tiko94/SwiftyWebSocket"}

end
