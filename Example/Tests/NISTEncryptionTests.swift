//
//  NISTEncryptionTests.swift
//  UncommonCrypto
//
//  Created by Daniel Loewenherz on 6/28/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import UncommonCrypto

struct NISTTestVector {
    var key: Data
    var iv: Data
    var plaintext: Data
    var cipherText: Data
}

func handler(_ text: String, result: NSTextCheckingResult, idx: Int) -> Data {
    return Data(hexString: (text as NSString).substring(with: result.rangeAt(idx)))
}

protocol BundleAble: class {
    static func testBundle() -> Bundle
}

extension XCTestCase: BundleAble {
    static func testBundle() -> Bundle {
        return Bundle(for: self)
    }
}

func testVectorsFromFile(_ path: String) -> [NISTTestVector] {
    let contents = try! String(contentsOfFile: path)

    let nistTestVectorPattern = "COUNT = (\\d*)\r\nKEY = ([a-f0-9]+)\r\nIV = ([a-f0-9]+)\r\nPLAINTEXT = ([a-f0-9]+)\r\nCIPHERTEXT = ([a-f0-9]+)"
    let nistTestVectorExpression = try! NSRegularExpression(pattern: nistTestVectorPattern, options: NSRegularExpression.Options())
    let range = NSMakeRange(0, contents.characters.count)

    var vectors: [NISTTestVector] = []
    nistTestVectorExpression.enumerateMatches(in: contents, options: NSRegularExpression.MatchingOptions(), range: range) { (result, flags, ptr) in
        guard let result = result else { return }
        var results = [2, 3, 4, 5].map { handler(contents, result: result, idx: $0) }
        vectors.append(NISTTestVector(key: results[0], iv: results[1], plaintext: results[2], cipherText: results[3]))
    }

    return vectors
}

// http://csrc.nist.gov/groups/STM/cavp/documents/aes/KAT_AES.zip
// http://csrc.nist.gov/groups/STM/cavp/block-ciphers.html#test-vectors
class NISTBlockCipherSpec: XCTestCase {
    func path(_ resource: String) -> String {
        let bundle = NISTBlockCipherSpec.testBundle()
        return bundle.path(forResource: resource, ofType: "rsp")!
    }

    func _test(_ resource: String) {
        for vector in testVectorsFromFile(path(resource)) {
            let cryptor = Cryptor<AES128>(key: vector.key)
            let result: Data = try! cryptor.encrypt(data: vector.plaintext, iv: vector.iv, mode: .pkcs7)
            expect(result) == vector.cipherText
        }
    }

    func testCBCGFSbox128GFSBox() {
        _test("CBCGFSbox128")
    }

    func testCBCGFSbox128KeySbox() {
        _test("CBCKeySbox128")
    }

    func testCBCGFSbox128VarKey() {
        _test("CBCVarKey128")
    }

    func testtestCBCGFSbox128() {
        _test("CBCGFSbox128")
    }

    func testCBCKeySbox128() {
        _test("CBCKeySbox128")
    }

    func testCBCVarKey128() {
        _test("CBCVarKey128")
    }

    func testCBCVarTxt128() {
        _test("CBCVarTxt128")
    }

    func testCFB128GFSbox128() {
        _test("CFB128GFSbox128")
    }

    func testCFB128GFSbox192() {
        _test("CFB128GFSbox192")
    }

    func testCFB128GFSbox256() {
        _test("CFB128GFSbox256")
    }

    func testCFB128KeySbox128() {
        _test("CFB128KeySbox128")
    }

    func testCFB128KeySbox192() {
        _test("CFB128KeySbox192")
    }

    func testCFB128KeySbox256() {
        _test("CFB128KeySbox256")
    }

    func testCFB128VarKey128() {
        _test("CFB128VarKey128")
    }

    func testCFB128VarKey192() {
        _test("CFB128VarKey192")
    }

    func testCFB128VarKey256() {
        _test("CFB128VarKey256")
    }

    func testCFB128VarTxt128() {
        _test("CFB128VarTxt128")
    }

    func testCFB128VarTxt192() {
        _test("CFB128VarTxt192")
    }

    func testCFB128VarTxt256() {
        _test("CFB128VarTxt256")
    }

    // MARK: TODO -

    /*
    func testCFB1GFSbox128() {
        _test("CFB1GFSbox128")
    }

    func testCFB1KeySbox128() {
        _test("CFB1KeySbox128")
    }

    func testCFB1VarKey128() {
        _test("CFB1VarKey128")
    }

    func testCFB1VarTxt128() {
        _test("CFB1VarTxt128")
    }

    func testCFB8GFSbox128() {
        _test("CFB8GFSbox128")
    }

    func testCFB8KeySbox128() {
        _test("CFB8KeySbox128")
    }

    func testCFB8VarKey128() {
        _test("CFB8VarKey128")
    }

    func testCFB8VarTxt128() {
        _test("CFB8VarTxt128")
    }
 */

    func testECBGFSbox128() {
        _test("ECBGFSbox128")
    }
    
    func testECBKeySbox128() {
        _test("ECBKeySbox128")
    }
    
    func testECBVarKey128() {
        _test("ECBVarKey128")
    }
    
    func testECBVarTxt128() {
        _test("ECBVarTxt128")
    }
    
    func testOFBGFSbox128() {
        _test("OFBGFSbox128")
    }
    
    func testOFBKeySbox128() {
        _test("OFBKeySbox128")
    }
    
    func testOFBVarKey128() {
        _test("OFBVarKey128")
    }
    
    func testOFBVarTxt128() {
        _test("OFBVarTxt128")
    }
}
