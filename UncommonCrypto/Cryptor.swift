//
//  Cryptor.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

enum CryptorError: ErrorType {
    case Unspecified
}

public enum CCEncryptionOption {
    case PKCS7
    case ECB

    var value: Int {
        switch self {
        case .PKCS7:
            return kCCOptionPKCS7Padding

        case .ECB:
            return kCCOptionECBMode
        }
    }
}

struct EncryptedData<Algorithm, CCEncryptionAlgorithmProtocol> {
    var data: NSData
    var iv: NSData
    var salt: NSData
}

public struct Cryptor<Algorithm: CCEncryptionAlgorithmProtocol where Algorithm: CCKeySizeProtocol, Algorithm.KeySize: KeySizeContainer> {
    var keyData: NSData

    // MARK: - 🚀 Initializers

    public init?(password: String, encoding: NSStringEncoding) {
        guard let theKeyData = password.dataUsingEncoding(encoding) else {
            return nil
        }

        keyData = theKeyData
    }

    public init(key: DataConvertible, saltSize: Int = 32) {
        keyData = key.convert()
        let salt = try! Random<NSData>.generate(8)
//        PBKDF2<Algorithm, SHA1>.key(password: <#T##DataConvertible#>, keySize: <#T##Algorithm.KeySize#>, completion: <#T##(key: [UInt8], salt: [UInt8]) -> τ_0_0#>)
    }

    // MARK: -

    public func encrypt<T: CCRandomContainer where T.CCRandomContainerType == T>(data theData: DataConvertible, saltSize: Int = 32, mode: CCEncryptionOption = .PKCS7) throws -> T {
        let salt = try Random<NSData>.generate(8)
        return try encrypt(data: theData, salt: salt, mode: mode)
    }

    public func encrypt<T: CCRandomContainer where T.CCRandomContainerType == T>(data theData: DataConvertible, salt: DataConvertible, mode: CCEncryptionOption = .PKCS7) throws -> T {
        let iv = try Random<NSData>.generate(Algorithm.blockSize)
        return try encrypt(data: theData, iv: iv, salt: salt, mode: mode)
    }

    public func encrypt<T: CCRandomContainer where T.CCRandomContainerType == T>(data theData: DataConvertible, iv: DataConvertible, salt: DataConvertible, mode: CCEncryptionOption) throws -> T {
        var theData = theData.convert()
        var iv = iv.convert()

        let dataOutAvailable = theData.length + Algorithm.blockSize
        var dataOut = [UInt8](count: dataOutAvailable, repeatedValue: 0)
        var dataOutMoved = 0

        let status = Int(CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(Algorithm.fun), CCOptions(mode.value), keyData.bytes, keyData.length, iv.bytes, theData.bytes, theData.length, &dataOut, dataOut.count, &dataOutMoved))

        if status != kCCSuccess {
            throw CryptorError.Unspecified
        }

        return T.handler(dataOut)
    }

    public mutating func update() {
        Cryptor(key: "test")
    }
}