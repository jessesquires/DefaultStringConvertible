Pod::Spec.new do |s|
   s.name = 'DefaultStringConvertible'
   s.version = '1.0.0'
   s.license = 'MIT'

   s.summary = 'A default CustomStringConvertible implementation for Swift types'
   s.homepage = 'https://github.com/jessesquires/DefaultStringConvertible'
   s.documentation_url = 'http://www.jessesquires.com/DefaultStringConvertible/'
   s.social_media_url = 'https://twitter.com/jesse_squires'
   s.author = 'Jesse Squires'

   s.source = { :git => 'https://github.com/jessesquires/DefaultStringConvertible.git', :tag => s.version }
   s.source_files = 'Sources/*.swift'

   s.ios.deployment_target = '8.0'
   s.osx.deployment_target = '10.10'
   s.tvos.deployment_target = '9.0'
   s.watchos.deployment_target = '2.0'

   s.requires_arc = true
end
