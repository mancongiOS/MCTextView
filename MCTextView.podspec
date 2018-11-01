
Pod::Spec.new do |s|
s.name         = "MCTextView"
s.version      = "1.0"
s.summary      = "MCTextView for ios."
s.homepage     = "https://github.com/mancongiOS/MCTextView"
s.license      = "MIT"
s.author       = { "MC" => "562863544@qq.com" }
s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/mancongiOS/MCTextView.git", :tag => "1.0" }
s.source_files = "MCTextView/MCTextView/*.swift"
s.ios.deployment_target = '8.0'

end
