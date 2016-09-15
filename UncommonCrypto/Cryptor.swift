//
//  Cryptor.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

enum CryptorError: Int, Error {
    case unspecified
    case paramError       = -4300
    case bufferTooSmall   = -4301
    case memoryFailure    = -4302
    case alignmentError   = -4303
    case decodeError      = -4304
    case unimplemented    = -4305
    case overflow         = -4306
    case rngFailure       = -4307

    init?(status: CCCryptorStatus) {
        if status != CCCryptorStatus(kCCSuccess) {
            let result = CryptorError(rawValue: Int(status)) ?? CryptorError.unspecified
            self = result
        }
        else {
            return nil
        }
    }
}

public enum CCEncryptionOption {
    case pkcs7
    case ecb

    var value: Int {
        switch self {
        case .pkcs7:
            return kCCOptionPKCS7Padding

        case .ecb:
            return kCCOptionECBMode
        }
    }
}

struct EncryptedData<Algorithm, CCEncryptionAlgorithmProtocol> {
    var data: Data
    var iv: Data
    var salt: Data
}

public struct Key {

}

public struct Cryptor<Algorithm: CCEncryptionAlgorithmProtocol> where Algorithm: CCKeySizeProtocol, Algorithm.KeySize: KeySizeContainer {
    var key: Data

    // MARK: - 🚀 Initializers

    public init?(key theKey: DataConvertible, encoding: String.Encoding) {
        guard let theKey = theKey.convert(encoding) else {
            return nil
        }

        key = theKey
    }

    public init(key theKey: DataConvertible) {
        key = theKey.convert()

        DES.KeySize.default
    }

    // MARK: -

    public func encrypt<T: CCByteContainer>(data theData: DataConvertible, mode: CCEncryptionOption = .pkcs7) throws -> T where T.CCByteContainerType == T {
        let iv = Data(bytes: [0])
        return try encrypt(data: theData, iv: iv, mode: mode)
    }

    public func encrypt<T: CCByteContainer>(data: DataConvertible, iv: DataConvertible, mode: CCEncryptionOption) throws -> T where T.CCByteContainerType == T {
        var data = data.convert() as NSData
        let iv = iv.convert() as NSData
        let keyData = key as NSData

        var dataOut = [UInt8](repeating: 0, count: data.length + Algorithm.blockSize)
        var dataOutMoved = 0

        let status = CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(Algorithm.fun), CCOptions(mode.value), keyData.bytes, keyData.length, iv.bytes, data.bytes, data.length, &dataOut, dataOut.count, &dataOutMoved)

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
