//
//  Cryptor.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/24/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation
import CommonCrypto

struct EncryptedData<Algorithm, CCEncryptionAlgorithmProtocol> {
    var data: NSData
    var iv: NSData
    var salt: NSData
}

public struct Cryptor<Algorithm: CCEncryptionAlgorithmProtocol> {
    var keyData: NSData

    // MARK: - 🚀 Initializers

    init?(key theKey: String) {
        guard let theKeyData = theKey.dataUsingEncoding(CryptoDefaults.encoding) else {
            return nil
        }

        self.init(keyData: theKeyData)
    }

    init(keyData theKeyData: NSData) {
        keyData = NSMutableData(data: theKeyData)
    }

    // MARK: -

    func encrypt(data theData: NSData) -> [UInt8] {
//        CCPBKDFAlgorithm
        var iv = 0

        kCCKeySizeDES
        let dataOutAvailable = theData.length + Algorithm.blockSize
        var dataOut = [UInt8](count: dataOutAvailable, repeatedValue: 0)
        var dataOutMoved = 0

        CCCrypt(CCOperation(kCCEncrypt), CCAlgorithm(Algorithm.fun), CCOptions(kCCOptionPKCS7Padding), keyData.bytes, keyData.length, &iv, theData.bytes, theData.length, &dataOut, dataOutAvailable, &dataOutMoved)

        return dataOut
    }

    mutating func update() {
        Cryptor(key: "test")
    }
}