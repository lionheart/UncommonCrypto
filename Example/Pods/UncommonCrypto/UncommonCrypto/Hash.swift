//
//  SwiftCrypt.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto
import CZLib

public struct Hash<Algorithm: SecureHashAlgorithm>: Digestable {
    public var data: NSMutableData

    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType

    public var bytes: [UInt8] {
        var value = [UInt8](count: Int(Algorithm.length), repeatedValue: 0)
        if let fun = Algorithm.fun as? CCSecureHashAlgorithmTypeSignature {
            fun(data.bytes, CC_LONG(data.length), &value)
        }
        else if let fun = Algorithm.fun as? LibZSecureHashAlgorithmTypeSignature {
            
        }
        return value
    }

    // MARK: - 🚀 Initializers

    public init?(text: String, textEncoding encoding: UInt) {
        guard let theData = text.dataUsingEncoding(encoding) else {
            return nil
        }

        self.init(data: theData)
    }

    public init(text: String) {
        // All text can be UTF8-encoded, so this won't be an optional.
        self.init(text: text, textEncoding: NSUTF8StringEncoding)!
    }

    public init(bytes: [UInt8]) {
        self.init(data: NSData(bytes: bytes))
    }

    public init(data theData: NSData) {
        data = NSMutableData(data: theData)
    }

    // MARK: -

    public mutating func update(text: String) {
        // All text can be UTF8-encoded, so this won't be an optional.
        try! update(text, textEncoding: NSUTF8StringEncoding)
    }

    public mutating func update(text: String, textEncoding encoding: UInt) throws {
        if let theData = text.dataUsingEncoding(encoding) {
            data.appendData(theData)
        }
        else {
            throw ChecksumError.DataConversionError
        }
    }

    public mutating func update(data theData: NSData) {
        data.appendData(theData)
    }
}
