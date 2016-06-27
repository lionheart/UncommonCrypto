//
//  Algorithms.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto
import CZLib

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

extension Adler32: ZLibSecureHashAlgorithm {
    public static var fun: ZLibSecureHashAlgorithmTypeSignature { return CZLib.adler32 }
    public static var length: Int32 { return 32 }
}

extension CRC32: ZLibSecureHashAlgorithm {
    public static var fun: ZLibSecureHashAlgorithmTypeSignature { return crc32 }
    public static var length: Int32 { return 32 }
}

extension MD2: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_MD2 }
    public static var length: Int32 { return CC_MD2_DIGEST_LENGTH }
}

extension MD4: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_MD4 }
    public static var length: Int32 { return CC_MD4_DIGEST_LENGTH }
}

extension MD5: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_MD5 }
    public static var length: Int32 { return CC_MD5_DIGEST_LENGTH }
}

extension SHA1: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_SHA1 }
    public static var length: Int32 { return CC_SHA1_DIGEST_LENGTH }
}

extension SHA224: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_SHA224 }
    public static var length: Int32 { return CC_SHA224_DIGEST_LENGTH }
}

extension SHA256: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_SHA256 }
    public static var length: Int32 { return CC_SHA256_DIGEST_LENGTH }
}

extension SHA384: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_SHA384 }
    public static var length: Int32 { return CC_SHA384_DIGEST_LENGTH }
}

extension SHA512: CCSecureHashAlgorithm {
    public static var fun: CCSecureHashAlgorithmTypeSignature { return CC_SHA512 }
    public static var length: Int32 { return CC_SHA512_DIGEST_LENGTH }
}

// MARK: - HMAC

extension MD5: CCHMACAlgorithmProtocol {
    static var hmac: Int = kCCHmacAlgMD5
}

extension SHA1: CCHMACAlgorithmProtocol {
    static var hmac: Int = kCCHmacAlgSHA1
}

extension SHA224: CCHMACAlgorithmProtocol {
    static var hmac: Int = kCCHmacAlgSHA224
}

extension SHA256: CCHMACAlgorithmProtocol {
    static var hmac: Int = kCCHmacAlgSHA256
}

extension SHA384: CCHMACAlgorithmProtocol {
    static var hmac: Int = kCCHmacAlgSHA384
}

extension SHA512: CCHMACAlgorithmProtocol {
    static var hmac: Int = kCCHmacAlgSHA512
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
    typealias KeySize = Int
}

extension AES128: CCKeySizeProtocol {
    enum KeySize: KeySizeContainer {
        case Size128
        case Size192
        case Size256

        var value: Int {
            switch self {
            case .Size128: return kCCKeySizeAES128
            case .Size192: return kCCKeySizeAES192
            case .Size256: return kCCKeySizeAES256
            }
        }
    }
}

extension DES: CCKeySizeProtocol {
    enum KeySize: KeySizeContainer {
        case Default

        var value: Int {
            return kCCKeySizeDES
        }
    }
}

extension TripleDES: CCKeySizeProtocol {
    enum KeySize: KeySizeContainer {
        case Default

        var value: Int {
            return kCCKeySize3DES
        }
    }
}

extension CAST: CCKeySizeProtocol {
    struct KeySizeContainer: VariableKeySizeContainer {
        static var minValue: Int { return kCCKeySizeMinCAST }
        static var maxValue: Int { return kCCKeySizeMaxCAST }
    }

    typealias KeySize = VariableKeySize<KeySizeContainer>
}

extension RC4: CCKeySizeProtocol {
    struct KeySizeContainer: VariableKeySizeContainer {
        static var minValue: Int { return kCCKeySizeMinRC4 }
        static var maxValue: Int { return kCCKeySizeMaxRC4 }
    }

    typealias KeySize = VariableKeySize<KeySizeContainer>
}

extension RC2: CCKeySizeProtocol {
    struct KeySizeContainer: VariableKeySizeContainer {
        static var minValue: Int { return kCCKeySizeMinRC2 }
        static var maxValue: Int { return kCCKeySizeMaxRC2 }
    }

    typealias KeySize = VariableKeySize<KeySizeContainer>
}

extension Blowfish: CCKeySizeProtocol {
    struct KeySizeContainer: VariableKeySizeContainer {
        static var minValue: Int { return kCCKeySizeMinBlowfish }
        static var maxValue: Int { return kCCKeySizeMaxBlowfish }
    }

    typealias KeySize = VariableKeySize<KeySizeContainer>
}

// MARK: - Pseudo Random

extension SHA1: CCPseudoRandomHmacAlgorithmProtocol {
    static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA1
}

extension SHA224: CCPseudoRandomHmacAlgorithmProtocol {
    static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA224
}

extension SHA256: CCPseudoRandomHmacAlgorithmProtocol {
    static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA256
}

extension SHA384: CCPseudoRandomHmacAlgorithmProtocol {
    static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA384
}

extension SHA512: CCPseudoRandomHmacAlgorithmProtocol {
    static var pseudoRandomAlgorithm = kCCPRFHmacAlgSHA512
}
