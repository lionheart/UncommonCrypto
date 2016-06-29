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

