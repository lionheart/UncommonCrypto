//
//  KeyDerivation.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

let kPBKDFSaltSize = 8

enum KeyDerivationError: ErrorType {
    case InvalidParameters
}

protocol Int8Protocol { }
extension Int8: Int8Protocol {}

extension Array where Element: Int8Protocol {
    var pointer: UnsafePointer<Int8> {
        var copy = self
        return UnsafePointer<Int8>(withUnsafeMutablePointer(&copy) { $0 })
    }
}

extension String {
    var pointer: UnsafePointer<CChar> {
        return withCString { $0 }
    }
}

/*
 Algorithm is used to determine key length.
 Hash is used to determine the PRF.
 */
public struct PBKDF2<Algorithm, Hash where Algorithm: CCKeySizeProtocol, Hash: CCPseudoRandomHmacAlgorithmProtocol, Algorithm.KeySize: KeySizeContainer> {
    public static func key<T>(password password: String, saltLength: Int, rounds: Int = 10000, keySize: Algorithm.KeySize, @noescape completion: (key: [UInt8], salt: NSData) -> T) throws -> T {
        let salt: NSData = try Random<NSData>.generate(saltLength)
        return try key(password: password, salt: salt, rounds: rounds, keySize: keySize, completion: completion)
    }

    public static func key<T>(password password: DataConvertible, salt: DataConvertible, rounds: Int, keySize: Algorithm.KeySize, @noescape completion: (key: [UInt8], salt: NSData) -> T) throws -> T {
        let salt = salt.convert()
        let saltPtr = UnsafePointer<UInt8>(salt.bytes)

        var key = [UInt8](count: keySize.value, repeatedValue: 0)
        let passwordData = password.convert()
        let passwordPtr = UnsafePointer<Int8>(passwordData.bytes)

        let result = CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), passwordPtr, passwordData.length, saltPtr, salt.length, CCPseudoRandomAlgorithm(Hash.pseudoRandomAlgorithm), UInt32(rounds), &key, key.count)

        if Int(result) == kCCParamError {
            throw KeyDerivationError.InvalidParameters
        }

        return completion(key: key, salt: salt)
    }
}

typealias PBKDF2SHA1 = PBKDF2<SHA1, SHA1>
//typealias PBKDF2SHA224 = PBKDF2<SHA224, SHA224>
//typealias PBKDF2SHA256 = PBKDF2<SHA256, SHA256>
//typealias PBKDF2SHA384 = PBKDF2<SHA384, SHA384>
//typealias PBKDF2SHA512 = PBKDF2<SHA512, SHA512>
