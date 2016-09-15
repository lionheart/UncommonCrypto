//
//  NSString+UncommonCrypto.swift
//  Pods
//
//  Created by Daniel Loewenherz on 6/27/16.
//
//

import Foundation

public extension NSString {
    convenience init(bytes: [UInt8]) {
        self.init(bytes: bytes, encoding: String.Encoding.utf8.rawValue)!
    }

    convenience init?(bytes: [UInt8], encoding: UInt) {
        var bytes = bytes
        self.init(bytes: &bytes, length: bytes.count, encoding: encoding)
    }
}
