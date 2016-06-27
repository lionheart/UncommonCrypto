//
//  Random.swift
//  Pods
//
//  Created by Daniel Loewenherz on 6/27/16.
//
//

import Foundation

enum SecRandomError: ErrorType {
    case Unspecified
}

public protocol CCRandomContainer {
    associatedtype CCRandomContainerType

    static func handler(bytes: [UInt8]) -> CCRandomContainerType
}

extension String: CCRandomContainer {
    public typealias CCRandomContainerType = String

    public static func handler(bytes: [UInt8]) -> String {
        var result = String()
        for byte in bytes {
            result.append(UnicodeScalar(byte))
        }
        return result
    }
}

extension NSData: CCRandomContainer {
    public typealias CCRandomContainerType = NSData

    public static func handler(bytes: [UInt8]) -> NSData {
        return NSData(bytes: bytes)
    }
}

extension Array: CCRandomContainer {
    public typealias CCRandomContainerType = [UInt8]

    public static func handler(bytes: [UInt8]) -> CCRandomContainerType {
        return bytes.map { UInt8($0) }
    }
}

public struct Random<T: CCRandomContainer where T.CCRandomContainerType == T> {
    public static func generate(length: Int = 8) throws -> T {
        var output = [UInt8](count: length, repeatedValue: 0)
        let result = SecRandomCopyBytes(kSecRandomDefault, length, &output)

        if result == -1 {
            throw SecRandomError.Unspecified
        }
        
        return T.handler(output)
    }
}

