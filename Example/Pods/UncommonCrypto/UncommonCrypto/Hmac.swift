//
//  Hmac.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

struct Hmac<Algorithm: CCHMACAlgorithmProtocol>: Digestable {
    var keyData: NSMutableData
    var messageData: NSMutableData

    var bytes: [UInt8] {
        var hmac: [UInt8] = pointer(Int(Algorithm.length))
        CCHmac(Algorithm.hmacAlgorithm, keyData.bytes, keyData.length, messageData.bytes, messageData.length, &hmac)
        return hmac
    }

    // MARK: - 🚀 Initializers

    init?(key theKey: String, message: String, messageEncoding encoding: UInt = NSUTF8StringEncoding) {
        guard let theKeyData = theKey.dataUsingEncoding(encoding) else {
            return nil
        }

        if let theMessageData = message.dataUsingEncoding(encoding) {
            self.init(keyData: theKeyData, messageData: theMessageData)
        }
        else {
            self.init(keyData: theKeyData)
        }
    }

    init?(key theKey: String, encoding: UInt = NSUTF8StringEncoding) {
        guard let theKeyData = theKey.dataUsingEncoding(encoding) else {
            return nil
        }

        self.init(keyData: theKeyData)
    }

    init(keyData theKeyData: NSData, messageData theMessageData: NSData) {
        keyData = NSMutableData(data: theKeyData)
        messageData = NSMutableData(data: theMessageData)
    }

    init(keyData theKeyData: NSData) {
        keyData = NSMutableData(data: theKeyData)
        messageData = NSMutableData()
    }

    // MARK: -

    mutating func update(text: String, textEncoding encoding: UInt = NSUTF8StringEncoding) throws {
        if let theData = text.dataUsingEncoding(encoding) {
            messageData.appendData(theData)
        }
        else {
            throw ChecksumError.DataConversionError
        }
    }

    mutating func update(data: NSData) {
        messageData.appendData(data)
    }
}