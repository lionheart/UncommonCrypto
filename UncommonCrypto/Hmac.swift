//
//  Hmac.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

public struct Hmac<Algorithm: CCHMACAlgorithmProtocol>: CustomStringConvertible, CustomReflectable, ByteOutput {
    var keyData: Data
    var messageData: Data

    // MARK: 🚀 Initializers

    public init?(key theKey: DataConvertible, message: DataConvertible?, messageEncoding encoding: String.Encoding) {
        guard let theKeyData = theKey.convert(encoding),
            let theMessageData = (message ?? Data()).convert(encoding) else {
            return nil
        }

        self.init(key: theKeyData, message: theMessageData)
    }

    public init(key theKey: DataConvertible, message: DataConvertible? = nil) {
        keyData = theKey.convert()
        messageData = (message ?? Data()).convert()
    }

    // MARK: -

    public mutating func update(_ input: DataConvertible, textEncoding encoding: String.Encoding = String.Encoding.utf8) throws {
        if let theData = input.convert(encoding) {
            messageData.append(theData)
        }
        else {
            throw ChecksumError.dataConversionError
        }
    }

    public mutating func update(_ input: DataConvertible) {
        messageData.append(input.convert())
    }

    // MARK: CustomStringConvertible
    public var description: String {
        return "HMAC-" + Algorithm.name
    }

    // MARK: CustomReflectable
    public var customMirror: Mirror {
        return Mirror(self, children: [
            "hexdigest": hexdigest,
            "bytes": String(describing: bytes),
            "string": string,
            "base64": base64
        ])
    }

    // MARK: ByteOutput
    public var bytes: [UInt8] {
        return Algorithm.process((keyData as Data, messageData as Data))
    }
}
