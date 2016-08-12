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

public struct Random<T: CCRandomContainer> {}

public extension Random where T: CCByteContainer {
    public static func generate(length: Int = 8) throws -> T.CCByteContainerType {
        var output = [UInt8](count: length, repeatedValue: 0)
        let result = SecRandomCopyBytes(kSecRandomDefault, length, &output)

        if result == -1 {
            throw SecRandomError.Unspecified
        }

        return T.handler(output)
    }
}

public extension Random where T.CCRandomContainerType == Int {
    public static func generate() -> Int {
        return random()
    }

    public static func generate(range: Range<UInt32>) -> Int {
        if let maxElement = range.maxElement() {
            let minElement = range.minElement() ?? 0
            return Int(arc4random_uniform(maxElement) + minElement)
        }

        return generate()
    }
}

public extension Random where T.CCRandomContainerType == Double {
    init() {
        srand48(time(nil))
    }

    @available(*, unavailable, message="Double random numbers must be seeded. Please initialize this object and use the `generate()` instance method instead.")
    public static func generate() -> Void {}

    public func generate() -> Double {
        return drand48()
    }
}