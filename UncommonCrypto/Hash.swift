//
//  SwiftCrypt.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

public struct Hash<Algorithm: CCHashAlgorithmProtocol>: Digestable {
    var data: NSMutableData

    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType

    public var digest: [UInt8] {
        var value = [UInt8](count: Int(Algorithm.length), repeatedValue: 0)
        Algorithm.fun(data.bytes, CC_LONG(data.length), &value)
        return value
    }

    // MARK: - 🚀 Initializers

    public init?(text: String, textEncoding encoding: UInt = NSUTF8StringEncoding) {
        guard let theData = text.dataUsingEncoding(encoding) else {
            return nil
        }

        self.init(data: theData)
    }

    public init(bytes: [UInt8]) {
        self.init(data: NSData(bytes: bytes))
    }

    public init(data theData: NSData) {
        data = NSMutableData(data: theData)
    }

    // MARK: -

    public mutating func update(text: String, textEncoding encoding: UInt = NSUTF8StringEncoding) throws {
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
