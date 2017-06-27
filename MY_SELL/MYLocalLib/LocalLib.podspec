#
#  Be sure to run `pod spec lint LocalLib.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|



  s.name         = "LocalLib"
  s.version      = "0.0.2"
  s.summary      = "LocalLib."
  s.description  = <<-DESC
           description for LocalLib longer than summary
                   DESC

  s.homepage     = "http://git.oschina.net/MYStrict/my_sell"

  s.license      = "MIT"

  s.author             = { "yanma" => "lingyuyan123@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :path => "LocalLib", :tag => "#{s.version}" }

  s.source_files  = "LocalLib", "LocalLib/**/*"

 # s.frameworks = "SomeFramework", "AnotherFramework"

   s.requires_arc = true

# s.dependency "AFNetworking", "~> 3.1.0"

end
