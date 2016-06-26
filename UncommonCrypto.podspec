Pod::Spec.new do |s|
  s.name             = 'UncommonCrypto'
  s.version          = '1.0.0'
  s.summary          = 'A short description of UncommonCrypto.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/lionheartsw/UncommonCrypto'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Dan Loewenherz' => 'dan@lionheartsw.com' }
  s.source           = { :git => 'https://github.com/lionheartsw/UncommonCrypto.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/lionheartsw'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'UncommonCrypto/**/*.{swift,c,h,m}'

  # Create module.map files for CommonCrypto framework
  s.preserve_paths = "Frameworks"
  s.prepare_command = <<-CMD
    sh ./modulemap.sh
  CMD

  # add the new module to Import Paths
  s.xcconfig = {
    "SWIFT_INCLUDE_PATHS" => "$(PODS_ROOT)/UncommonCrypto/Frameworks/$(PLATFORM_NAME)", 
    "FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/UncommonCrypto/Frameworks/$(PLATFORM_NAME)"
    "OTHER_LDFLAGS" => "-framework CommonCrypto"
  }

#  s.ios.vendored_frameworks = "Frameworks/iphoneos/CommonCrypto.framework"
#  s.osx.vendored_frameworks = "Frameworks/macos/CommonCrypto.framework"
#  s.tvos.vendored_frameworks = "Frameworks/tvos/CommonCrypto.framework"
#  s.watchos.vendored_frameworks = "Frameworks/watchsimulator/CommonCrypto.framework"
end
