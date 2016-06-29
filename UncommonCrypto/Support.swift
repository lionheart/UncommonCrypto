//
//  Support.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

public typealias CCSecureHashAlgorithmTypeSignature = (UnsafePointer<Void>, CC_LONG, UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>
//public typealias ZLibHashAlgorithmTypeSignature = (uLong, UnsafePointer<Bytef>, uInt) -> uLong
public typealias CCAlgorithmParameters = (fun: CCSecureHashAlgorithmTypeSignature, length: Int32)

// MARK: - CryptoDefaults

public struct CryptoDefaults {
    static var encoding = NSUTF8StringEncoding
}

// MARK: - Errors

public enum ChecksumError: ErrorType {
    case DataConversionError
}

// MARK: - Protocols

public protocol HashAlgorithm {
    static var length: Int32 { get }
}

public protocol CCSecureHashAlgorithm: HashAlgorithm {
    static var fun: CCSecureHashAlgorithmTypeSignature { get }
}

public protocol ZLibHashAlgorithm: HashAlgorithm {
//    static var fun: ZLibHashAlgorithmTypeSignature { get }
}

protocol CCHMACAlgorithmProtocol: HashAlgorithm {
    static var hmac: Int { get }
    static var hmacAlgorithm: CCHmacAlgorithm { get }
}

public protocol CCKeySizeProtocol {
    associatedtype KeySize
}

public protocol CCEncryptionAlgorithmProtocol {
    static var fun: Int { get }
    static var blockSize: Int { get }
}

public protocol CCPseudoRandomHmacAlgorithmProtocol {
    static var pseudoRandomAlgorithm: Int { get }
}

public protocol ZeroBit {
    static var zero: Self { get }
}

public protocol KeySizeContainer {
    var value: Int { get }
}

public protocol VariableKeySizeContainer {
    static var minValue: Int { get }
    static var maxValue: Int { get }
}

public enum VariableKeySize<T where T: VariableKeySizeContainer>: KeySizeContainer {
    case Min
    case Max
    case Variable(Int)

    public var value: Int {
        switch self {
        case .Min:
            return T.minValue

        case .Max:
            return T.maxValue

        case .Variable(let v):
            if v < T.minValue {
                return T.minValue
            }
            else if v > T.maxValue {
                return T.maxValue
            }
            else {
                return v
            }
        }
    }
}

// MARK: - Protocol Extensions

extension CCHMACAlgorithmProtocol {
    static var hmacAlgorithm: UInt32 { return CCHmacAlgorithm(hmac) }
}

extension Int8: ZeroBit {
    public static var zero: Int8 { return 0 }
}

extension UInt8: ZeroBit {
    public static var zero: UInt8 { return 0 }
}

extension Int: KeySizeContainer {
    public var value: Int { return self }
}

// MARK: - Functions

func pointer<T where T: ZeroBit>(length: Int) -> [T] {
    return [T](count: length, repeatedValue: T.zero)
}

// MARK: - Type Aliases

public typealias MD2Hash = Hash<MD2>
public typealias MD4Hash = Hash<MD4>
public typealias MD5Hash = Hash<MD5>
public typealias SHA1Hash = Hash<SHA1>
public typealias SHA224Hash = Hash<SHA224>
public typealias SHA256Hash = Hash<SHA256>
public typealias SHA384Hash = Hash<SHA384>
public typealias SHA512Hash = Hash<SHA512>

// MARK: - Data Convertible

public protocol DataConvertible {
    func convert(encoding: NSStringEncoding?) -> NSData?
    func convert() -> NSData
}

extension DataConvertible {
    public func convert() -> NSData {
        return convert(nil)!
    }
}

extension NSData: DataConvertible {
    public func convert(encoding: NSStringEncoding?) -> NSData? {
        return self
    }
}

extension Array: DataConvertible {
    public func convert(encoding: NSStringEncoding?) -> NSData? {
        let bytes: [UInt8] = map { UInt8($0 as? Int ?? 0) }
        return NSData(bytes: bytes)
    }
}

extension String: DataConvertible {
    public func convert(encoding: NSStringEncoding?) -> NSData? {
        return dataUsingEncoding(encoding ?? CryptoDefaults.encoding)
    }
}

// MARK: - CCRandomContainer

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