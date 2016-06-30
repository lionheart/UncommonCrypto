<p align="center">
<img src="logo.png" />

[![CI Status](http://img.shields.io/travis/Dan Loewenherz/UncommonCrypto.svg?style=flat)](https://travis-ci.org/Dan Loewenherz/UncommonCrypto)
[![Version](https://img.shields.io/cocoapods/v/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)
[![License](https://img.shields.io/cocoapods/l/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)
[![Platform](https://img.shields.io/cocoapods/p/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)

</p>

--

UncommonCrypto is a pure Swift wrapper for Apple's [CommonCrypto](https://opensource.apple.com/source/CommonCrypto/) cryptography library.

## Features

* [x] Pure Swift support for the entire CommonCrypto API
* [x] Extensive documentation
* [x] Comprehensive test coverage (>3,000 individual test cases developed by the IETF and NIST)
* [x] Cocoapods support
* [x] Carthage support
* [ ] Swift Package Manager support

### Requirements

* iOS 8.0+, macOS 10.10+, watchOS 2.0+, and tvOS 9.0+
* Xcode 7.3+

### Features

* [x] [Secure Hashes](#secure-hashing)
  * [x] MD5
  * [x] SHA1
  * [x] SHA224
  * [x] SHA256
  * [x] SHA384
  * [x] SHA512
* [ ] Checksums
  * [ ] CRC32
  * [ ] Adler32
* [x] [HMAC](#hmac)
  * [x] MD5
  * [x] SHA1
  * [x] SHA224
  * [x] SHA256
  * [x] SHA384
  * [x] SHA512
* [x] [Encryption](#Encryption)
  * [x] AES128
  * [x] DES
  * [x] 3DES
  * [x] CAST
* [x] PBKDF / Key Derivation
* [x] Random Number Generation

### Secure Hashing

UncommonCrypto implements all secure hashing algorithms provided by CommonCrypto (`MD2`, `MD4`, `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, and `SHA512`). Hashes can be generated by providing a string, `NSData` instance, or a byte array.

* [x] String

  ```swift
  "message digest".MD5.hexdigest
  // f96b697d7cb7938d525a2f31aaf161d0
  ```

* [x] Data

  ```swift
  NSData(contentsOfFile: "your_file.txt").SHA256.hexdigest
  ```

* [x] Bytes

  ```swift
  [144, 1, 80, 152, 60, 210, 79, 176, 214, 150, 63, 125, 40, 225, 127, 114].SHA1.hexdigest
  // af5da9f45af7a300e3aded972f8ff687
  ```

##### Output

Once you've instantiated a hash object, You can read the underlying message digest in a variety of ways.

* [x] Hex digest:

  ```swift
  hash.hexdigest
  // 74e6f7298a9c2d168935f58c001bad88
  ```

* [x] Byte array:

  ```swift
  hash.bytes
  // [175, 93, 169, 244, 90, 247, 163, 0, 227, 173, 237, 151, 47, 143, 246, 135]
  ```

* [x] UTF8-encoded `String`:

  ```
  hash.string
  // ¯]©ôZ÷£ ã­í/ö
  ```

* [x] NSData:

  ```
  hash.data
  // <74e6f729 8a9c2d16 8935f58c 001bad88>
  ```

##### Advanced Hash API

The extensions on String, NSData, and Array<Int> are supported by a lower-level API. If you want to use it directly, it's exposed on the `Hash<T>` struct, where `T` is any of the supported hash algorithms.

```swift
Hash<MD5>("message digest").hexdigest
// f96b697d7cb7938d525a2f31aaf161d0
```

Note that if you try to use an unsupported algorithm with `Hash<T>`, you'll get a compile-time error. Type-safety FTW.

<img src="screenshot1.png" width="691" />

Supported secure hash algorithms include all of the ones provided by CommonCrypto--`MD2`, `MD4`, `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, and `SHA512`. However, if you use `MD2` or `MD4`, you will get a deprecation warning since [they've both][1] [been obsoleted][2] by the IETF (you really shouldn't be using them).

<img src="screenshot2.png" width="694" />

If you'd like to append additional data to a hash, use the `update` method. If you provide an encoding, `update` will throw an error if the provided string can't be converted into the specified encoding.

```swift
var hash = Hash<MD5>("message")
hash.update(" digest")
hash.hexdigest
// f96b697d7cb7938d525a2f31aaf161d0
```

`update` is a mutating method, so if you instantiate a hash as a constant, the compiler will complain.

<img src="screenshot3.png" width="553" />

If you want to specify a string _and_ an encoding, you'll need to handle data conversion errors. See the [Swift Developer Documentation][3] for more info.

```swift
do {
    try hash.update(" digest", textEncoding: NSASCIIStringEncoding)
} catch ChecksumError.DataConversionError {
    // Uh oh.
} catch {
    // Well, this is awkward.
}
```

### HMAC

HMAC values can be calculated with the `Hmac<T>` struct, where `T` is any of the secure hash algorithms provided by CommonCrypto (`MD2`, `MD4`, `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, or `SHA512`).

```swift
let hmac = Hmac<MD5>(key: "", message: "")
```

the `key` and `message` parameters 

`Hmac<T>` can also b

#### Output

Like `Hash<T>`, you can read HMAC values in a variety of ways.

* [x] Hex digest:

  ```swift
  hmac.hexdigest
  // 74e6f7298a9c2d168935f58c001bad88
  ```

* [x] Byte array:

  ```swift
  hmac.bytes
  // [116, 230, 247, 41, 138, 156, 45, 22, 137, 53, 245, 140, 0, 27, 173, 136]
  ```

* [x] UTF8-encoded `String`:

  ```swift
  hmac.string
  // tæ÷)-5õ ­
  ```

* [x] NSData:

  ```swift
  hmac.data
  // <74e6f729 8a9c2d16 8935f58c 001bad88>
  ```

* [x] Base64

  ```swift
  hmac.base64
  // dOb3KYqcLRaJNfWMAButiA==
  ```

## Additional Extensions

UncommonCrypto also comes bundled with some helpful extensions on Array, String, and NSData to aid in byte manipulation and instantiation.

## Test Coverage

There's still some work to do here. I've tried to be thorough, we are dealing with cryptography here, after all...

* [x] Digests
  * [x] MD2 with [IETF][4] test cases.
  * [x] MD4 with [IETF][5] test cases.
  * [x] MD5 with [IETF][6] test cases.
  * [x] SHA1 with [IETF][7] test cases.
  * [x] SHA224 with [IETF][7] test cases.
  * [x] SHA256 with [IETF][7] test cases.
  * [x] SHA384 with [IETF][7] test cases.
  * [x] SHA512 with [IETF][7] test cases.
* [ ] HMAC
  * [ ] MD5
  * [x] SHA1
  * [x] SHA224
  * [x] SHA256
  * [x] SHA384
  * [x] SHA512
* [ ] Encryption
  * [x] AES128 with [NIST][8] test vectors. Comprises ~3,000 individual test cases (!).
  * [ ] DES
  * [ ] 3DES
  * [ ] CAST
* [x] PBKDF / Key Derivation
* [ ] Random Number Generation

## Installation

### Cocoapods

UncommonCrypto is available through [CocoaPods][9]. To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'UncommonCrypto', '~> 1.0'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager for Cocoa application. To install the carthage tool, you can use [Homebrew](http://brew.sh).

``` bash
$ brew update
$ brew install carthage
```

To integrate UncommonCrypto into your Xcode project using Carthage, specify it in your `Cartfile`:

``` ogdl
github "lionheart/UncommonCrypto" ~> 1.0
```

Then, run the following command to build the Kingfisher framework:

``` bash
$ carthage update
```

At last, you need to set up your Xcode project manually to add the Kingfisher framework.

On your application targets’ “General” settings tab, in the “Linked Frameworks and Libraries” section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following content:

```
/usr/local/bin/carthage copy-frameworks
```

and add the paths to the frameworks you want to use under “Input Files”:

```
$(SRCROOT)/Carthage/Build/iOS/UncommonCrypto.framework
```

For more information about how to use Carthage, please see its [project page](https://github.com/Carthage/Carthage).

### Manually

It is not recommended to install the framework manually, but if you prefer not to use either of the aforementioned dependency managers, you can integrate UncommonCrypto into your project manually. A regular way to use UncommonCrypto in your project would be using Embedded Framework.

- Add UncommonCrypto as a [submodule](http://git-scm.com/docs/git-submodule). In your favorite terminal, `cd` into your top-level project directory, and entering the following command:

``` bash
$ git submodule add https://github.com/onevcat/UncommonCrypto.git
```

- Open the `UncommonCrypto` folder, and drag `UncommonCrypto.xcodeproj` into the file navigator of your app project, under your app project.
- In Xcode, navigate to the target configuration window by clicking on the blue project icon, and selecting the application target under the "Targets" heading in the sidebar.
- In the tab bar at the top of that window, open the "Build Phases" panel.
- Expand the "Target Dependencies" group, and add `UncommonCrypto.framework`.
- Click on the `+` button at the top left of "Build Phases" panel and select "New Copy Files Phase". Rename this new phase to "Copy Frameworks", set the "Destination" to "Frameworks", and add `UncommonCrypto.framework` of the platform you need.

## Author

Dan Loewenherz, dan@lionheartsw.com

## License

UncommonCrypto is available under the Apache 2.0 license. See the [LICENSE](LICENSE) file for details.

[1]: https://tools.ietf.org/html/rfc6149
[2]: https://tools.ietf.org/html/rfc6150
[3]: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ErrorHandling.html
[4]: https://tools.ietf.org/html/rfc1319#appendix-A.5
[5]: https://tools.ietf.org/html/rfc1320#appendix-A.5
[6]: https://tools.ietf.org/html/rfc1321#appendix-A.5
[7]: https://tools.ietf.org/html/rfc6234#section-8.5
[8]: http://csrc.nist.gov/groups/STM/cavp/block-ciphers.html#test-vectors
[9]: http://cocoapods.org
