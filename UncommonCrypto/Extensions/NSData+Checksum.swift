//
//  Data.swift
//  iDocent
//
//  Created by Daniel Loewenherz on 6/10/16.
//  Copyright © 2016 Lionheart Software LLC. All rights reserved.
//

import Foundation

public extension NSData {
    var MD2: MD2Hash { return checksum() }
    var MD4: MD4Hash { return checksum() }
    var MD5: MD5Hash { return checksum() }
    var SHA1: SHA1Hash { return checksum() }
    var SHA224: SHA224Hash { return checksum() }
    var SHA256: SHA256Hash { return checksum() }
    var SHA384: SHA384Hash { return checksum() }
    var SHA512: SHA512Hash { return checksum() }

    private func checksum<T: CCHashAlgorithmProtocol>() -> Hash<T> {
        return Hash<T>(data: self)
    }
}