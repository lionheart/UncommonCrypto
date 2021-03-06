//
//  SwiftCrypt.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

public struct Hash<Algorithm: CCSecureHashAlgorithm>: CustomStringConvertible, CustomReflectable, ByteOutput {
    fileprivate var data: Data

    public typealias StringLiteralType = String
    public typealias UnicodeScalarLiteralType = StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType

    // MARK: 🚀 Initializers

    public init?(_ input: DataConvertible, textEncoding encoding: UInt) {
        guard let theData = input.convert(String.Encoding(rawValue: encoding)) else {
            return nil
        }

        self.init(theData)
    }

    public init(_ input: DataConvertible) {
        data = input.convert()
    }

    // MARK: -

    public mutating func update(_ input: DataConvertible) {
        data.append(input.convert())
    }

    public mutating func update(_ input: DataConvertible, textEncoding encoding: UInt) throws {
        guard let theData = input.convert(String.Encoding(rawValue: encoding)) else {
            throw ChecksumError.dataConversionError
        }

        update(theData)
    }

    // MARK: ByteOutput
    public var bytes: [UInt8] {
        return Algorithm.process(data)
    }

    // MARK: CustomStringConvertible
    public var description: String {
        return Algorithm.name
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
}

/*
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
 */
