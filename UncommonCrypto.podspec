# The portions of this Pod specification that generate the CommonCrypto
# framework module are from https://github.com/sgl0v/SCrypto, used with
# attribution under the MIT License:
#
# Copyright (c) 2010-2016 Maksym Shcheglov
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

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
  }
end
