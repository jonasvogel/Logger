# Be sure to run `pod lib lint phrase_swift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Logger'
  s.version          = '1.0.0'
  s.summary          = 'A very simple, but extensible logger for Swift projects.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Log debug and error messages directly to the console and extend the logging for production/release builds in order to forward errors to your favourite reporting tool.
                       DESC

  s.homepage         = 'https://github.com/jonasvogel/logger'
  s.license          = { :type => 'MIT License', :file => 'LICENSE' }
  s.author           = { 'Jonas Vogel' => 'jonas@jonasvogel.name' }
  s.source           = { :git => 'https://github.com/jonasvogel/logger.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.swift_versions = ['5.3']

  s.source_files = 'Sources/*/*.swift'

  s.frameworks = 'Foundation'
end
