//
//  Support.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto
import ZLib

public typealias CCSecureHashAlgorithmTypeSignature = (UnsafePointer<Void>, CC_LONG, UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8>
public typealias ZLibHashAlgorithmTypeSignature = (uLong, UnsafePointer<Bytef>, uInt) -> uLong
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
    static var fun: ZLibHashAlgorithmTypeSignature { get }
}

protocol CCHMACAlgorithmProtocol: HashAlgorithm {
    static var hmac: Int { get }
    static var hmacAlgorithm: CCHmacAlgorithm { get }
}

protocol CCKeySizeProtocol {
    associatedtype KeySize
}

public protocol CCEncryptionAlgorithmProtocol {
    static var fun: Int { get }
    static var blockSize: Int { get }
}

protocol CCPseudoRandomHmacAlgorithmProtocol {
    static var pseudoRandomAlgorithm: Int { get }
}

public protocol ZeroBit {
    static var zero: Self { get }
}

protocol KeySizeContainer {
    var value: Int { get }
}

protocol VariableKeySizeContainer {
    static var minValue: Int { get }
    static var maxValue: Int { get }
}

enum VariableKeySize<T where T: VariableKeySizeContainer>: KeySizeContainer {
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
    var value: Int { return self }
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