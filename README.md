<center>![](logo.png)</center>

[![CI Status](http://img.shields.io/travis/Dan Loewenherz/UncommonCrypto.svg?style=flat)](https://travis-ci.org/Dan Loewenherz/UncommonCrypto)
[![Version](https://img.shields.io/cocoapods/v/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)
[![License](https://img.shields.io/cocoapods/l/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)
[![Platform](https://img.shields.io/cocoapods/p/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)

--

UncommonCrypto is a pure Swift wrapper for Apple's [CommonCrypto](https://opensource.apple.com/source/CommonCrypto/) cryptography library.

## Features

* [x] iOS, macOS, watchOS, and tvOS support
* [x] Comprehensive documentation
* [x] Test coverage with IETF and NIST test vectors
* [x] Cocoapods support
* [ ] Carthage support
* [ ] Swift Package Manager support

## CommonCrypto Features

* [x] Secure Hashes
  * [x] MD5
  * [x] SHA1
  * [x] SHA224
  * [x] SHA256
  * [x] SHA384
  * [x] SHA512
* [x] HMAC
  * [x] MD5
  * [x] SHA1
  * [x] SHA224
  * [x] SHA256
  * [x] SHA384
  * [x] SHA512
* [x] Encryption
  * [x] AES128
  * [x] DES
  * [x] 3DES
  * [x] CAST
* [x] PBKDF / Key Derivation

### Other, but useful additions

* [x] Random Number Generation
* [ ] Checksums (work in progress)
  * [ ] CRC32
  * [ ] Adler32

## Secure Hashes

`MD2`, `MD4`, `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, and `SHA512` are all fully tested and implemented.

#### String

```swift
var hash = "message digest".MD5.hexdigest
// f96b697d7cb7938d525a2f31aaf161d0
```

#### Data

NSData objects can also be used directly, just like strings.

```swift
let hash = NSData(contentsOfFile: "your_file.txt").SHA256
hash.hexdigest
```

#### Bytes

You can also calculate the message digest from an Array of bytes.

```swift
let hash = [144, 1, 80, 152, 60, 210, 79, 176, 214, 150, 63, 125, 40, 225, 127, 114].SHA1
hash.hexdigest
// af5da9f45af7a300e3aded972f8ff687
```

### Alternate Outputs

You can read the underlying checksum in a variety of ways.

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

### Lower-Level Hash API

The extensions on String, NSData, and Array<Int> are supported by a lower-level API. If you want to use it directly, it's exposed on the `Hash<T>` struct, where `T` is any of the supported hash algorithms.

```swift
Hash<MD5>("message digest").hexdigest
// f96b697d7cb7938d525a2f31aaf161d0
```

Note that if you try to use an unsupported algorithm with `Hash<T>`, you'll get a compile-time error. Type-safety FTW.

![](screenshot1.png)

Supported secure hash algorithms include all of the ones provided by CommonCrypto--`MD2`, `MD4`, `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, and `SHA512`. However, if you use `MD2` or `MD4`, you will get a deprecation warning since [they've both](https://tools.ietf.org/html/rfc6149) [been obsoleted](https://tools.ietf.org/html/rfc6150) by the IETF (you really shouldn't be using them at all).

![](screenshot2.png)

## HMAC

HMAC values can be calculated with the `Hmac<T>` struct, where `T` is any of the secure hash algorithms (`MD2`, `MD4`, `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, or `SHA512`).

```swift
let hmac = Hmac<MD5>(key: "", message: "")
```

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

  ```
  hmac.string
  // tæ÷)-5õ ­
  ```

* [x] NSData:

  ```
  hmac.data
  // <74e6f729 8a9c2d16 8935f58c 001bad88>
  ```

## Additional Extensions

UncommonCrypto also comes bundled with some helpful extensions on Array, String, and NSData to aid in byte manipulation and instantiation.

## Test Coverage

There's still some work to do here. I've tried to be thorough, we are dealing with cryptography here, after all...

* [x] Digests
  * [x] MD2 with [IETF](https://tools.ietf.org/html/rfc1319#appendix-A.5) test vectors.
  * [x] MD4 with [IETF](https://tools.ietf.org/html/rfc1320#appendix-A.5) test vectors.
  * [x] MD5 with [IETF](https://tools.ietf.org/html/rfc1321#appendix-A.5) test vectors.
  * [x] SHA1 with [IETF](https://tools.ietf.org/html/rfc6234#section-8.5) test vectors.
  * [x] SHA224 with [IETF](https://tools.ietf.org/html/rfc6234#section-8.5) test vectors.
  * [x] SHA256 with [IETF](https://tools.ietf.org/html/rfc6234#section-8.5) test vectors.
  * [x] SHA384 with [IETF](https://tools.ietf.org/html/rfc6234#section-8.5) test vectors.
  * [x] SHA512 with [IETF](https://tools.ietf.org/html/rfc6234#section-8.5) test vectors.
* [x] HMAC
  * [ ] MD5
  * [x] SHA1
  * [x] SHA224
  * [x] SHA256
  * [x] SHA384
  * [x] SHA512
* [ ] Encryption
  * [x] AES128 with [NIST](http://csrc.nist.gov/groups/STM/cavp/block-ciphers.html#test-vectors) test vectors. Comprises ~3,000 individual test cases.
  * [ ] DES
  * [ ] 3DES
  * [ ] CAST
* [x] PBKDF / Key Derivation
* [ ] Random Number Generation

## Installation

UncommonCrypto is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
platform :ios, '9.0'

pod "UncommonCrypto"
```

## Author

Dan Loewenherz, dan@lionheartsw.com

## License

UncommonCrypto is available under the Apache 2.0 license. See the [LICENSE](LICENSE) file for details.

