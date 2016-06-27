<center>![](logo.png)</center>

[![CI Status](http://img.shields.io/travis/Dan Loewenherz/UncommonCrypto.svg?style=flat)](https://travis-ci.org/Dan Loewenherz/UncommonCrypto)
[![Version](https://img.shields.io/cocoapods/v/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)
[![License](https://img.shields.io/cocoapods/l/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)
[![Platform](https://img.shields.io/cocoapods/p/UncommonCrypto.svg?style=flat)](http://cocoapods.org/pods/UncommonCrypto)

--

UncommonCrypto is a pure Swift wrapper for Apple's [CommonCrypto](https://opensource.apple.com/source/CommonCrypto/) cryptography library.

## API Features

* [x] Digests
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
* [ ] Encryption
  * [ ] AES128
  * [ ] DES
  * [ ] 3DES
  * [ ] CAST
* [x] PBKDF / Key Derivation
* [x] Random Number Generation

## Usage

### Digest

`MD2`, `MD4`, `MD5`, `SHA1`, `SHA224`, `SHA256`, `SHA384`, and `SHA512` are all available.

### Example

```swift
var digest = "abc".MD5!
print(digest.hexdigest)
// 900150983cd24fb0d6963f7d28e17f72

print(digest.bytes)
// [144, 1, 80, 152, 60, 210, 79, 176, 214, 150, 63, 125, 40, 225, 127, 114]

digest.update("abc")

print(digest.hexdigest)
// 440ac85892ca43ad26d44c7ad9d47d3e
```

You can also generate message digests using the Digest object.

```swift
let digest = Digest<MD5>(text: "abc")
```

or

```swift
let digest = Hash<MD5>(data: data)
```

#### hexdigest

```swift
cheksum.hexdigest
```

## Test Coverage

* [x] Digests
  * [x] MD5
  * [x] SHA1
  * [x] SHA224
  * [x] SHA256
  * [x] SHA384
  * [x] SHA512
* [ ] HMAC
  * [ ] MD5
  * [ ] SHA1
  * [ ] SHA224
  * [ ] SHA256
  * [ ] SHA384
  * [ ] SHA512
* [ ] Encryption
  * [ ] AES128
  * [ ] DES
  * [ ] 3DES
  * [ ] CAST
* [ ] PBKDF / Key Derivation
* [ ] Random Number Generation

## Installation

UncommonCrypto is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "UncommonCrypto"
```

## Author

Dan Loewenherz, dan@lionheartsw.com

## License

UncommonCrypto is available under the Apache 2.0 license. See the [LICENSE](LICENSE) file for details.

