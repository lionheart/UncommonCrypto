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

enum KeyDerivationError: Error {
    case invalidParameters
    case invalidKeySize
}

/*
 Algorithm is used to determine key length.
 Hash is used to determine the PRF.
 */
public struct PBKDF2<Algorithm, Hash> where Algorithm: CCKeySizeProtocol, Hash: CCPseudoRandomHmacAlgorithmProtocol, Algorithm.KeySize: KeySizeContainer {
    public static func key<T>(password: String, saltLength: Int, rounds: Int = 10000, keySize: Algorithm.KeySize, completion: (Data, Data) -> T) throws -> T {
        let salt: Data = try Random<Data>.generate(saltLength)
        return try key(password: password, salt: salt as DataConvertible, rounds: rounds, keySize: keySize, completion: completion)
    }

    @available(*, unavailable)
    public static func key<T>(password: DataConvertible, salt: DataConvertible, rounds: Int, keySize: Algorithm.KeySize?, completion: (Data, Data) -> T) throws -> T {
        throw KeyDerivationError.invalidParameters
    }

    public static func key<T>(password: DataConvertible, salt: DataConvertible, rounds: Int, keySize: Algorithm.KeySize, completion: (Data, Data) -> T) throws -> T {
        guard let keySizeValue = keySize.value else {
            throw KeyDerivationError.invalidKeySize
        }

        let salt = salt.convert()
        let saltPtr = (salt as NSData).bytes.bindMemory(to: UInt8.self, capacity: salt.count).withMemoryRebound(to: UInt8.self, capacity: salt.count) { $0 }

        var key = NSMutableData(length: keySizeValue)!
        var keyPtr = key.bytes.bindMemory(to: UInt8.self, capacity: key.length).withMemoryRebound(to: UInt8.self, capacity: key.length) { $0 }

        let passwordData = password.convert()
        let passwordPtr = (passwordData as NSData).bytes.bindMemory(to: Int8.self, capacity: passwordData.count).withMemoryRebound(to: Int8.self, capacity: passwordData.count) { $0 }

        let result = CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), passwordPtr, passwordData.count, saltPtr, salt.count, CCPseudoRandomAlgorithm(Hash.pseudoRandomAlgorithm), UInt32(rounds), keyPtr, key.length)

        if Int(result) == kCCParamError {
            throw KeyDerivationError.invalidParameters
        }

        return completion(key as Data, salt)
    }
}

typealias PBKDF2SHA1 = PBKDF2<SHA1, SHA1>
//typealias PBKDF2SHA224 = PBKDF2<SHA224, SHA224>
//typealias PBKDF2SHA256 = PBKDF2<SHA256, SHA256>
//typealias PBKDF2SHA384 = PBKDF2<SHA384, SHA384>
//typealias PBKDF2SHA512 = PBKDF2<SHA512, SHA512>
