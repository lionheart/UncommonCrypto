//
//  Data.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

enum NSDataError: Error {
    case conversionError
}

public extension Data {
    @available(*, deprecated, message: "Obsoleted in IETF RFC 6149")
    var MD2: MD2Hash { return checksum() }

    @available(*, deprecated, message: "Obsoleted in IETF RFC 6150")
    var MD4: MD4Hash { return checksum() }

    var MD5: MD5Hash { return checksum() }
    var SHA1: SHA1Hash { return checksum() }
    var SHA224: SHA224Hash { return checksum() }
    var SHA256: SHA256Hash { return checksum() }
    var SHA384: SHA384Hash { return checksum() }
    var SHA512: SHA512Hash { return checksum() }

    fileprivate func checksum<T: HashAlgorithm>() -> Hash<T> {
        return Hash<T>(self as DataConvertible)
    }

    // MARK: 🚀 Initializers

    public init(hexString theHexString: String, force: Bool) throws {
        let characterSet = CharacterSet(charactersIn: "0123456789abcdefABCDEF")
        var hexString = ""
        for scalar in theHexString.unicodeScalars {
            if characterSet.contains(UnicodeScalar(UInt16(scalar.value))!) {
                hexString.append(String(scalar))
            }
            else if !force {
                throw NSDataError.conversionError
            }
        }

        if hexString.characters.count % 2 == 1 {
            if force {
                hexString = "0" + hexString
            }
            else {
                throw NSDataError.conversionError
            }
        }

        if hexString.characters.count == 0 {
            if force {
                hexString = "00"
            }
            else {
                throw NSDataError.conversionError
            }
        }

        var index = hexString.startIndex
        var bytes: [UInt8] = []
        repeat {
            bytes.append(hexString[index...hexString.index(after: index)].withCString {
                return UInt8(strtoul($0, nil, 16))
            })

            index = hexString.index(index, offsetBy: 2)
        } while hexString.distance(from: index, to: hexString.endIndex) != 0

        self.init(bytes: bytes)
    }

    public init(hexString: String) {
        try! self.init(hexString: hexString, force: true)
    }

    public var hexdigest: String {
        return reduce("") { carry, byte in
            return carry + String(format: "%02x", byte)
        }
    }
}
