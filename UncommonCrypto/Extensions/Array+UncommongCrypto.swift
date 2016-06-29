//
//  Array+UncommongCrypto.swift
//  Pods
//
//  Created by Daniel Loewenherz on 6/29/16.
//
//

import Foundation

public protocol Int8Protocol { }
extension Int8: Int8Protocol {}

public protocol UInt8Protocol { }
extension UInt8: UInt8Protocol {}
extension Int: UInt8Protocol { }

public extension Array where Element: Int8Protocol {
    var pointer: UnsafePointer<Int8> {
        var copy = self
        return UnsafePointer<Int8>(withUnsafeMutablePointer(&copy) { $0 })
    }
}

public extension Array where Element: UInt8Protocol {
    init(data: NSData) {
        self = Array(UnsafeMutableBufferPointer(start: UnsafeMutablePointer<Element>(data.bytes), count: data.length))
    }

    @available(*, deprecated, message="Obsoleted in IETF RFC 6149")
    var MD2: MD2Hash { return checksum() }

    @available(*, deprecated, message="Obsoleted in IETF RFC 6150")
    var MD4: MD4Hash { return checksum() }

    var MD5: MD5Hash { return checksum() }
    var SHA1: SHA1Hash { return checksum() }
    var SHA224: SHA224Hash { return checksum() }
    var SHA256: SHA256Hash { return checksum() }
    var SHA384: SHA384Hash { return checksum() }
    var SHA512: SHA512Hash { return checksum() }

    private func checksum<T: HashAlgorithm>() -> Hash<T> {
        return Hash<T>(self)
    }
}