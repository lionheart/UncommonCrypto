//
//  Hmac.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

struct Hmac<Algorithm: CCHMACAlgorithmProtocol> {
    var keyData: NSMutableData
    var messageData: NSMutableData

    // MARK: - 🚀 Initializers

    init?(key theKey: DataConvertible, message: DataConvertible?, messageEncoding encoding: UInt) {
        guard let theKeyData = theKey.convert(encoding),
            let theMessageData = (message ?? NSData()).convert(encoding) else {
            return nil
        }

        self.init(key: theKeyData, message: theMessageData)
    }

    init(key theKey: DataConvertible, message: DataConvertible? = nil) {
        keyData = NSMutableData(data: theKey.convert())
        messageData = NSMutableData(data: (message ?? NSData()).convert())
    }

    // MARK: -

    mutating func update(_ input: DataConvertible, textEncoding encoding: UInt = NSUTF8StringEncoding) throws {
        if let theData = input.convert(encoding) {
            messageData.appendData(theData)
        }
        else {
            throw ChecksumError.DataConversionError
        }
    }

    mutating func update(_ input: DataConvertible) {
        messageData.appendData(input.convert())
    }
}

extension Hmac where Algorithm: CCSecureHashAlgorithm {
    var bytes: [UInt8] {
        var hmac: [UInt8] = pointer(Int(Algorithm.length))
        CCHmac(Algorithm.hmacAlgorithm, keyData.bytes, keyData.length, messageData.bytes, messageData.length, &hmac)
        return hmac
    }

    var digest: String {
        var result = ""
        bytes.forEach { result.append(UnicodeScalar($0)) }
        return result
    }

    var hexdigest: String {
        return bytes.reduce("") { carry, byte in
            return carry + String(format: "%02x", byte)
        }
    }
}
