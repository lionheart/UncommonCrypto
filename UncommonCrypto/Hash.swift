//
//  SwiftCrypt.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto
import ZLib

public struct Hash<Algorithm: HashAlgorithm> {
    public var data: NSMutableData

    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType

    // MARK: - 🚀 Initializers

    public init?(input: DataConvertible, textEncoding encoding: UInt) {
        guard let theData = input.convert(encoding) else {
            return nil
        }

        self.init(input: theData)
    }

    public init(input: DataConvertible) {
        data = NSMutableData(data: input.convert())
    }

    // MARK: -

    public mutating func update(input: DataConvertible) {
        data.appendData(input.convert())
    }

    public mutating func update(input: DataConvertible, textEncoding encoding: UInt) throws {
        guard let theData = input.convert(encoding) else {
            throw ChecksumError.DataConversionError
        }

        update(theData)
    }
}

extension Hash where Algorithm: CCSecureHashAlgorithm {
    public var bytes: [UInt8] {
        var value = [UInt8](count: Int(Algorithm.length), repeatedValue: 0)
        Algorithm.fun(data.bytes, CC_LONG(data.length), &value)
        return value
    }

    public var digest: String {
        return String(bytes)
    }

    public var hexdigest: String {
        return bytes.reduce("") { carry, byte in
            return carry + String(format: "%02x", byte)
        }
    }
}

extension Hash where Algorithm: ZLibHashAlgorithm {
    public var checksum: UInt32 {
        var NULL: [Bytef] = [0]
        let hash = Algorithm.fun(0, &NULL, 0)
        var bytes = Array(UnsafeBufferPointer(start: UnsafePointer<UInt8>(data.bytes), count: data.length))
        let ptr = UnsafePointer<Bytef>(data.bytes)
        adler32(hash, &bytes, UInt32(bytes.count))
        return UInt32(hash)
    }
}