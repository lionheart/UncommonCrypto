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

    var bytes: [UInt8] {
        var hmac: [UInt8] = pointer(Int(Algorithm.length))
        CCHmac(Algorithm.hmacAlgorithm, keyData.bytes, keyData.length, messageData.bytes, messageData.length, &hmac)
        return hmac
    }

    // MARK: - 🚀 Initializers

    /**

     */
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

    mutating func update(input: DataConvertible, textEncoding encoding: UInt = NSUTF8StringEncoding) throws {
        if let theData = input.convert(encoding) {
            messageData.appendData(theData)
        }
        else {
            throw ChecksumError.DataConversionError
        }
    }

    mutating func update(data: DataConvertible) {
        messageData.appendData(data.convert())
    }
}
