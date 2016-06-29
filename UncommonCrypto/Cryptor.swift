//
//  Cryptor.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

enum CryptorError: Int, ErrorType {
    case Unspecified
    case ParamError       = -4300
    case BufferTooSmall   = -4301
    case MemoryFailure    = -4302
    case AlignmentError   = -4303
    case DecodeError      = -4304
    case Unimplemented    = -4305
    case Overflow         = -4306
    case RNGFailure       = -4307

    init?(status: CCCryptorStatus) {
        if status != CCCryptorStatus(kCCSuccess) {
            let result = CryptorError(rawValue: Int(status)) ?? CryptorError.Unspecified
            self = result
        }
        else {
            return nil
        }
    }
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

public struct Key {

}

public struct Cryptor<Algorithm: CCEncryptionAlgorithmProtocol where Algorithm: CCKeySizeProtocol, Algorithm.KeySize: KeySizeContainer> {
    var key: NSData

    // MARK: - 🚀 Initializers

    public init(key theKey: DataConvertible) {
        key = theKey.convert()
    }

    // MARK: -

    public func encrypt<T: CCRandomContainer where T.CCRandomContainerType == T>(data theData: DataConvertible, mode: CCEncryptionOption = .PKCS7) throws -> T {
        let iv = NSData(bytes: [0])
        return try encrypt(theData, iv: iv, mode: mode)
    }

    public func encrypt<T: CCRandomContainer where T.CCRandomContainerType == T>(data: DataConvertible, iv: DataConvertible, mode: CCEncryptionOption) throws -> T {
        var data = data.convert()
        var iv = iv.convert()

        var dataOut = [UInt8](count: data.length + Algorithm.blockSize, repeatedValue: 0)
        var dataOutMoved = 0

        let status = CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(Algorithm.fun), CCOptions(mode.value), key.bytes, key.length, iv.bytes, data.bytes, data.length, &dataOut, dataOut.count, &dataOutMoved)

        if let error = CryptorError(status: status) {
            throw error
        }

        let result = T.handler(Array(dataOut[0..<dataOutMoved/2]))
        return result
    }

    public mutating func update() {
        Cryptor(key: "test")
    }
}