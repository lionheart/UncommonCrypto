//
//  Support.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

public typealias CCSecureHashAlgorithmTypeSignature = (UnsafeRawPointer?, CC_LONG, UnsafeMutablePointer<UInt8>?) -> UnsafeMutablePointer<UInt8>?
//public typealias ZLibHashAlgorithmTypeSignature = (uLong, UnsafePointer<Bytef>, uInt) -> uLong
public typealias CCAlgorithmParameters = (fun: CCSecureHashAlgorithmTypeSignature, length: Int32)

// MARK: - CryptoDefaults

public struct CryptoDefaults {
    static var encoding = String.Encoding.utf8
}

// MARK: - Errors

public enum ChecksumError: Error {
    case dataConversionError
}

// MARK: - Protocols

public protocol ByteOutput {
    var bytes: [UInt8] { get }
}

public protocol HashAlgorithm {
    static var length: Int32 { get }
    static var name: String { get }
}

public protocol CCSecureHashAlgorithm: HashAlgorithm {
    static func process(_ data: Data) -> [UInt8]
    static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>
}

extension CCSecureHashAlgorithm {
    typealias Arguments = Data

    public static func process(_ data: Data) -> [UInt8] {
        var value = [UInt8](repeating: 0, count: Int(Self.length))
        let newData = data as NSData
        Self.fun(data: newData.bytes, len: CC_LONG(newData.length), md: &value)
        return value
    }
}

public protocol ZLibHashAlgorithm: HashAlgorithm {
//    static var fun: ZLibHashAlgorithmTypeSignature { get }
}

public protocol CCHMACAlgorithmProtocol: HashAlgorithm {
    static var hmac: Int { get }
    static var hmacAlgorithm: CCHmacAlgorithm { get }
}

extension CCHMACAlgorithmProtocol {
    typealias Arguments = (Data, Data)

    public static func process(_ data: (Data, Data)) -> [UInt8] {
        var value: [UInt8] = pointer(Int(Self.length))
        let newData1 = data.0 as NSData
        let newData2 = data.1 as NSData
        CCHmac(Self.hmacAlgorithm, newData1.bytes, newData1.length, newData2.bytes, newData2.length, &value)
        return value
    }
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
    var value: Int? { get }
}

public protocol VariableKeySizeContainer {
    static var minValue: Int { get }
    static var maxValue: Int { get }
}

public enum VariableKeySize<T>: KeySizeContainer where T: VariableKeySizeContainer {
    case min
    case max
    case variable(Int)

    public var value: Int? {
        switch self {
        case .min:
            return T.minValue

        case .max:
            return T.maxValue

        case .variable(let v):
            if v < T.minValue {
                return nil
            }
            else if v > T.maxValue {
                return nil
            }
            else {
                return v
            }
        }
    }
}

// MARK: - Protocol Extensions

extension CCHMACAlgorithmProtocol {
    public static var hmacAlgorithm: UInt32 { return CCHmacAlgorithm(hmac) }
}

extension Int8: ZeroBit {
    public static var zero: Int8 { return 0 }
}

extension UInt8: ZeroBit {
    public static var zero: UInt8 { return 0 }
}

extension Int: KeySizeContainer {
    public var value: Int? { return self }
}

// MARK: - Functions

func pointer<T>(_ length: Int) -> [T] where T: ZeroBit {
    return [T](repeating: T.zero, count: length)
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
    func convert(_ encoding: String.Encoding?) -> Data?
    func convert() -> Data
}

extension DataConvertible {
    public func convert() -> Data {
        return convert(nil)!
    }
}

extension Data: DataConvertible {
    public func convert(_ encoding: String.Encoding?) -> Data? {
        return self
    }
}

extension Array: DataConvertible {
    public func convert(_ encoding: String.Encoding?) -> Data? {
        let bytes: [UInt8] = map { UInt8($0 as? Int ?? 0) }
        return Data(bytes: bytes)
    }
}

extension String: DataConvertible {
    public func convert(_ encoding: String.Encoding?) -> Data? {
        return data(using: encoding ?? CryptoDefaults.encoding)
    }
}

// MARK: - CCRandomContainer

public protocol CCRandomContainer {
    associatedtype CCRandomContainerType
}

extension Int: CCRandomContainer {
    public typealias CCRandomContainerType = Int
}

extension UInt32: CCRandomContainer {
    public typealias CCRandomContainerType = UInt32
}

extension Double: CCRandomContainer {
    public typealias CCRandomContainerType = Double
}

extension String: CCRandomContainer {
    public typealias CCRandomContainerType = String
}

extension Data: CCRandomContainer {
    public typealias CCRandomContainerType = Data
}

extension Array: CCRandomContainer {
    public typealias CCRandomContainerType = [UInt8]
}

// MARK: - CCByteContainer

public protocol CCByteContainer {
    associatedtype CCByteContainerType

    static func handler(_ bytes: [UInt8]) -> CCByteContainerType
}

extension String: CCByteContainer {
    public typealias CCByteContainerType = String

    public static func handler(_ bytes: [UInt8]) -> String {
        var result = String()
        for byte in bytes {
            result.append(String(UnicodeScalar(byte)))
        }
        return result
    }
}

extension Data: CCByteContainer {
    public typealias CCByteContainerType = Data

    public static func handler(_ bytes: [UInt8]) -> Data {
        return Data(bytes: bytes)
    }
}

extension Array: CCByteContainer {
    public typealias CCByteContainerType = [UInt8]

    public static func handler(_ bytes: [UInt8]) -> CCByteContainerType {
        return bytes.map { UInt8($0) }
    }
}

// MARK: - ByteOutput


extension ByteOutput {
    public var data: Data {
        return Data(bytes: bytes)
    }

    public var string: String {
        var result = ""
        bytes.forEach { result.append(String(UnicodeScalar($0))) }
        return result
    }

    public var hexdigest: String {
        return bytes.reduce("") { carry, byte in
            return carry + String(format: "%02x", byte)
        }
    }

    public var base64: String {
        return data.base64EncodedString(options: Data.Base64EncodingOptions())
    }
}
