Pod::Spec.new do |spec|
  spec.name                     = "Savanna"
  spec.version                  = "0.0.1"
  spec.summary                  = "Savanna"
  spec.platform                 = :ios
  spec.license                  = { :type => 'Apache', :file => 'LICENSE' }
  spec.ios.deployment_target  = "5.1"
  spec.authors                  = { "Yang Zexin" => "yangzexin2011@gmail.com" }
  spec.homepage                 = "https://github.com/yangzexin/Savanna"
  spec.source                   = { :git => "#{spec.homepage}.git", :tag => "#{spec.version}" }
  spec.source_files             = "Savanna/*.{h,m}", "Vendor/lua-5.1.5/*.{h,c}"
  spec.resources                = "Savanna.bundle"
  spec.requires_arc             = false
  spec.frameworks               = 'UIKit', 'Foundation', 'CoreLocation', 'MapKit', 'AVFoundation', 'MediaPlayer', 'SystemConfiguration', 'MobileCoreServices'
  spec.libraries                = 'z', 'xml2', 'sqlite3'
  spec.dependency 'ASIHTTPRequest', '~> 1.8.2'
  spec.dependency 'ZipArchive', '~> 1.2.0'
  spec.dependency 'ZipKit', '~> 1.0.1'
end
