//
//  Algorithms.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

// MARK: - Full List

public struct Adler32 {}
public struct CRC32 {}

public struct MD2 {}
public struct MD4 {}
public struct MD5 {}
public struct SHA1 {}
public struct SHA224 {}
public struct SHA256 {}
public struct SHA384 {}
public struct SHA512 {}
public struct AES128 {}
public struct DES {}
public struct TripleDES {}
public struct CAST {}
public struct RC4 {}
public struct RC2 {}
public struct Blowfish {}

typealias AES = AES128

// MARK: - Hash

// MARK: TODO
/*
extension Adler32 {
    public static var fun: ZLibHashAlgorithmTypeSignature { return adler32 }
    public static var length: Int32 { return 32 }
}

// MARK: TODO
extension CRC32 {
    public static var fun: ZLibHashAlgorithmTypeSignature { return crc32 }
    public static var length: Int32 { return 32 }
}
 */

extension MD2: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_MD2_DIGEST_LENGTH }
    public static var name: String = "MD2"

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_MD2(data, len, md)
    }
}

extension MD4: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_MD4_DIGEST_LENGTH }
    public static var name: String = "MD2"

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_MD4(data, len, md)
    }
}

extension MD5: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_MD5_DIGEST_LENGTH }

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_MD5(data, len, md)
    }
}

extension SHA1: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_SHA1_DIGEST_LENGTH }

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_SHA1(data, len, md)
    }
}

extension SHA224: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_SHA224_DIGEST_LENGTH }

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_SHA224(data, len, md)
    }
}

extension SHA256: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_SHA256_DIGEST_LENGTH }

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_SHA256(data, len, md)
    }
}

extension SHA384: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_SHA384_DIGEST_LENGTH }

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_SHA384(data, len, md)
    }
}

extension SHA512: CCSecureHashAlgorithm {
    public static var length: Int32 { return CC_SHA512_DIGEST_LENGTH }

    public static func fun(data: UnsafeRawPointer, len: CC_LONG, md: UnsafeMutablePointer<UInt8>) -> UnsafeMutablePointer<UInt8> {
        return CC_SHA512(data, len, md)
    }
}

// MARK: - HMAC

extension MD5: CCHMACAlgorithmProtocol {
    public static var hmac: Int = kCCHmacAlgMD5
    public static var name: String = "MD5"
}

extension SHA1: CCHMACAlgorithmProtocol {
    public static var hmac: Int = kCCHmacAlgSHA1
    public static var name: String = "SHA1"
}

extension SHA224: CCHMACAlgorithmProtocol {
    public static var hmac: Int = kCCHmacAlgSHA224
    public static var name: String = "SHA224"
}

extension SHA256: CCHMACAlgorithmProtocol {
    public static var hmac: Int = kCCHmacAlgSHA256
    public static var name: String = "SHA256"
}

extension SHA384: CCHMACAlgorithmProtocol {
    public static var hmac: Int = kCCHmacAlgSHA384
    public static var name: String = "SHA384"
}

extension SHA512: CCHMACAlgorithmProtocol {
    public static var hmac: Int = kCCHmacAlgSHA512
    public static var name: String = "SHA512"
}

// MARK: - Encryption

extension AES128: CCEncryptionAlgorithmProtocol {
    public static var fun = kCCAlgorithmAES128
    public static var blockSize = kCCBlockSizeAES128
}

extension DES: CCEncryptionAlgorithmProtocol {
    public static var fun: Int = kCCAlgorithmDES
    public static var blockSize: Int = kCCBlockSizeDES
}

extension TripleDES: CCEncryptionAlgorithmProtocol {
    public static var fun: Int = kCCAlgorithm3DES
    public static var blockSize: Int = kCCBlockSize3DES
}

extension CAST: CCEncryptionAlgorithmProtocol {
    public static var fun: Int = kCCAlgorithmCAST
    public static var blockSize: Int = kCCBlockSizeCAST
}

/*
extension RC4: CCEncryptionAlgorithmProtocol {
    static var fun: Int = kCCAlgorithmRC4
    static var blockSize: Int = kCCBlockSizeRC2
}
 */

extension RC2: CCEncryptionAlgorithmProtocol {
    public static var fun: Int = kCCAlgorithmRC2
    public static var blockSize: Int = kCCBlockSizeRC2
}

extension Blowfish: CCEncryptionAlgorithmProtocol {
    public static var fun: Int = kCCAlgorithmBlowfish
    public static var blockSize: Int = kCCBlockSizeBlowfish
}

// MARK: - Key Size

extension SHA1: CCKeySizeProtocol {
    public typealias KeySize = Int
}

extension AES128: CCKeySizeProtocol {
    public enum KeySize: KeySizeContainer {
        case size128
        case size192
        case size256

        public var value: Int? {
            switch self {
            case .size128: return kCCKeySizeAES128
            case .size192: return kCCKeySizeAES192
            case .size256: return kCCKeySizeAES256
            }
        }
    }
}

extension DES: CCKeySizeProtocol {
    public enum KeySize: KeySizeContainer {
        case `default`

        public var value: Int? {
            return kCCKeySizeDES
        }
    }
}

extension TripleDES: CCKeySizeProtocol {
    public enum KeySize: KeySizeContainer {
        case `default`

        public var value: Int? {
            return kCCKeySize3DES
        }
    }
}

extension CAST: CCKeySizeProtocol {
    public struct KeySizeContainer: VariableKeySizeContainer {
        public static var minValue: Int { return kCCKeySizeMinCAST }
        public static var maxValue: Int { return kCCKeySizeMaxCAST }
    }

    public typealias KeySize = VariableKeySize<KeySizeContainer>
}

extension RC4: CCKeySizeProtocol {
    public struct KeySizeContainer: VariableKeySizeContainer {
        public static var minValue: Int { return kCCKeySizeMinRC4 }
        public static var maxValue: Int { return kCCKeySizeMaxRC4 }
    }

    public typealias KeySize = VariableKeySize<KeySizeContainer>
}

extension RC2: CCKeySizeProtocol {
    public struct KeySizeContainer: VariableKeySizeContainer {
        public static var minValue: Int { return kCCKeySizeMinRC2 }
        public static var maxValue: Int { return kCCKeySizeMaxRC2 }
    }

    public typealias KeySize = VariableKeySize<KeySizeContainer>
}

extension Blowfish: CCKeySizeProtocol {
    public struct KeySizeContainer: VariableKeySizeContainer {
        public static var minValue: Int { return kCCKeySizeMinBlowfish }
        public static var maxValue: Int { return kCCKeySizeMaxBlowfish }
    }

    public typealias KeySize = VariableKeySize<KeySizeContainer>
}

// MARK: - Pseudo Random

extension SHA1: CCPseudoRandomHmacAlgorithmProtocol {
    public static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA1
}

extension SHA224: CCPseudoRandomHmacAlgorithmProtocol {
    public static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA224
}

extension SHA256: CCPseudoRandomHmacAlgorithmProtocol {
    public static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA256
}

extension SHA384: CCPseudoRandomHmacAlgorithmProtocol {
    public static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA384
}

extension SHA512: CCPseudoRandomHmacAlgorithmProtocol {
    public static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA512
}
