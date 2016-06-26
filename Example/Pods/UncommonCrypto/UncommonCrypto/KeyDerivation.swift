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

enum SecRandomError: ErrorType {
    case Unspecified
}

func randomData(length: Int = 8) throws -> [UInt8] {
    var output = [UInt8](count: length, repeatedValue: 0)
    let result = SecRandomCopyBytes(kSecRandomDefault, length, &output)

    if result == -1 {
        throw SecRandomError.Unspecified
    }

    return output
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
struct PBKDF2<Algorithm, Hash where Algorithm: CCKeySizeProtocol, Hash: CCPseudoRandomHmacAlgorithmProtocol, Algorithm.KeySize: KeySizeContainer> {
    static func key(password password: String, salt: NSData? = nil, rounds: Int = 10000, keySize: Algorithm.KeySize, completion: (key: [UInt8], salt: [UInt8]) -> Void) throws {
        var cSalt: [UInt8]

        if let salt = salt {
            cSalt = [UInt8](count: salt.length, repeatedValue: 0)
            salt.getBytes(&cSalt, length: salt.length)
        }
        else {
            cSalt = try randomData()
        }

        var key = [UInt8](count: keySize.value, repeatedValue: 0)
        let passwordPtr = password.pointer

        let result = CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2), passwordPtr, Int(strlen(passwordPtr)), &cSalt, cSalt.count, CCPseudoRandomAlgorithm(Hash.pseudoRandomAlgorithm), UInt32(rounds), &key, key.count)

        if Int(result) == kCCParamError {
            throw KeyDerivationError.InvalidParameters
        }

        completion(key: key, salt: cSalt)
    }
}

func test() {
//    try! PBKDF2<Blowfish, SHA256>.key(<#T##password: String##String#>, keySize: <#T##Blowfish.KeySize#>, completion: <#T##(key: [UInt8], salt: [UInt8]) -> Void#>)
}


/*
struct PBKDF2<PRF: CCPseudoRandomHmacAlgorithmProtocol> {

}*/