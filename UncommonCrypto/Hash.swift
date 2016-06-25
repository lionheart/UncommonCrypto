//
//  SwiftCrypt.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

public struct Hash<Algorithm: CCHashAlgorithmProtocol>: Digestable {
    var data: NSMutableData

    public var digest: [UInt8] {
        var hash: [UInt8] = pointer(Int(Algorithm.length))
        Algorithm.fun(data.bytes, UInt32(data.length), &hash)
        return hash
    }

    // MARK: - 🚀 Initializers

    public init?(text: String, textEncoding encoding: UInt = NSUTF8StringEncoding) {
        guard let theData = text.dataUsingEncoding(encoding) else {
            return nil
        }

        self.init(data: theData)
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
