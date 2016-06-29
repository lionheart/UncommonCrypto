//
//  Data.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

public extension NSData {
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

    public convenience init(bytes: [UInt8]) {
        var bytes = bytes
        self.init(bytes: &bytes, length: bytes.count)
    }

    public convenience init(hexString: String) {
        let characterSet = NSCharacterSet(charactersInString: "0123456789abcdefABCDEF")
        var scalars = hexString.unicodeScalars.filter { characterSet.characterIsMember(UInt16($0.value)) }
        var hexString = ""
        for scalar in scalars {
            hexString.append(scalar)
        }

        if hexString.characters.count % 2 == 1 {
            hexString = "0" + hexString
        }

        var index = hexString.startIndex
        var bytes: [UInt8] = []
        repeat {
            bytes.append(hexString[index...index.advancedBy(1)].withCString {
                return UInt8(strtoul($0, nil, 16))
            })

            index = index.advancedBy(2)
        } while index.distanceTo(hexString.endIndex) != 0

        self.init(bytes: bytes)
    }

    public var hexdigest: String {
        let pointer = UnsafeBufferPointer(start: UnsafePointer<UInt8>(bytes), count: length)
        return pointer.reduce("") { carry, byte in
            return carry + String(format: "%02x", byte)
        }
    }
}