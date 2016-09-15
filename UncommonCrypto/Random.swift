//
//  Random.swift
//  Pods
//
//  Created by Daniel Loewenherz on 6/27/16.
//
//

import Foundation

enum SecRandomError: Error {
    case unspecified
}

public struct Random<T: CCRandomContainer> {}

public extension Random where T: CCByteContainer {
    public static func generate(_ length: Int = 8) throws -> T.CCByteContainerType {
        var output = [UInt8](repeating: 0, count: length)
        let result = SecRandomCopyBytes(kSecRandomDefault, length, &output)

        if result == -1 {
            throw SecRandomError.unspecified
        }

        return T.handler(output)
    }
}

public extension Random where T.CCRandomContainerType == UInt32 {
    public static func generate(_ range: Range<UInt32>) -> UInt32 {
        return arc4random_uniform(range.lowerBound) + range.lowerBound
    }
}

public extension Random where T.CCRandomContainerType == Int {
    public static func generate() -> Int {
        return Int(arc4random())
    }

    public static func generate(_ range: CountableRange<Int>) -> Int {
        let newRange: Range<UInt32> = (UInt32(range.lowerBound) ..< UInt32(range.upperBound))
        return Int(Random<UInt32>.generate(newRange))
    }
}

public extension Random where T.CCRandomContainerType == Double {
    init() {
        srand48(time(nil))
    }

    @available(*, unavailable, message: "Double random numbers must be seeded. Please initialize this object and use the `generate()` instance method instead.")
    public static func generate() -> Void {}

    public func generate() -> Double {
        return drand48()
    }
}
