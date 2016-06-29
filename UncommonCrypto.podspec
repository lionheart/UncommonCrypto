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
  s.preserve_paths = "Frameworks", "modulemap.sh"
  s.prepare_command = <<-CMD
    sh ./modulemap.sh

    require 'xcodeproj'
    path_to_project = "${SOURCE_ROOT}/${PROJECT_NAME}.xcodeproj"
    project = Xcodeproj::Project.open(path_to_project)
    main_target = project.targets.first
    phase = main_target.new_shell_script_build_phase("Name of your Phase")
    phase.shell_script = "TAGS="TODO:|FIXME:" && find "${SRCROOT}" \( -name "*.h" -or -name "*.m" \) -print0 | xargs -0 egrep --with-filename --line-number --only-matching "($TAGS).*\$" | perl -p -e "s/($TAGS)/ warning: \$1/""
    project.save()
  CMD

  # add the new module to Import Paths
  s.xcconfig = {
    "SWIFT_INCLUDE_PATHS" => "$(PODS_ROOT)/UncommonCrypto/Frameworks/$(PLATFORM_NAME)",
    "FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/UncommonCrypto/Frameworks/$(PLATFORM_NAME)",
  }
end
