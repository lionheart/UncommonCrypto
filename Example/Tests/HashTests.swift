import Nimble
import XCTest
@testable import UncommonCrypto

let TEST1 = "abc"
let TEST2_1 = "abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq"
let TEST2_2a = "abcdefghbcdefghicdefghijdefghijkefghijklfghijklmghijklmn"
let TEST2_2b = "hijklmnoijklmnopjklmnopqklmnopqrlmnopqrsmnopqrstnopqrstu"
let TEST2_2 = TEST2_2a + TEST2_2b
let TEST3 = String(count: 1000000, repeatedValue: Character("a"))
let TEST4a = "01234567012345670123456701234567"
let TEST4b = "01234567012345670123456701234567"
let TEST4 = Array(count: 10, repeatedValue: TEST4a + TEST4b).joinWithSeparator("")
let TEST7_1: [UInt8] = [0x49, 0xb2, 0xae, 0xc2, 0x59, 0x4b, 0xbe, 0x3a, 0x3b, 0x11, 0x75, 0x42, 0xd9, 0x4a, 0xc8]
let TEST8_1: [UInt8] = [0x9a, 0x7d, 0xfd, 0xf1, 0xec, 0xea, 0xd0, 0x6e, 0xd6, 0x46, 0xaa, 0x55, 0xfe, 0x75, 0x71, 0x46]
let TEST9_1: [UInt8] = [0x65, 0xf9, 0x32, 0x99, 0x5b, 0xa4, 0xce, 0x2c, 0xb1, 0xb4, 0xa2, 0xe7, 0x1a, 0xe7, 0x02, 0x20, 0xaa, 0xce, 0xc8, 0x96, 0x2d, 0xd4, 0x49, 0x9c, 0xbd, 0x7c, 0x88, 0x7a, 0x94, 0xea, 0xaa, 0x10, 0x1e, 0xa5, 0xaa, 0xbc, 0x52, 0x9b, 0x4e, 0x7e, 0x43, 0x66, 0x5a, 0x5a, 0xf2, 0xcd, 0x03, 0xfe, 0x67, 0x8e, 0xa6, 0xa5, 0x00, 0x5b, 0xba, 0x3b, 0x08, 0x22, 0x04, 0xc2, 0x8b, 0x91, 0x09, 0xf4, 0x69, 0xda, 0xc9, 0x2a, 0xaa, 0xb3, 0xaa, 0x7c, 0x11, 0xa1, 0xb3, 0x2a]
let TEST10_1: [UInt8] = [0xf7, 0x8f, 0x92, 0x14, 0x1b, 0xcd, 0x17, 0x0a, 0xe8, 0x9b, 0x4f, 0xba, 0x15, 0xa1, 0xd5, 0x9f, 0x3f, 0xd8, 0x4d, 0x22, 0x3c, 0x92, 0x51, 0xbd, 0xac, 0xbb, 0xae, 0x61, 0xd0, 0x5e, 0xd1, 0x15, 0xa0, 0x6a, 0x7c, 0xe1, 0x17, 0xb7, 0xbe, 0xea, 0xd2, 0x44, 0x21, 0xde, 0xd9, 0xc3, 0x25, 0x92, 0xbd, 0x57, 0xed, 0xea, 0xe3, 0x9c, 0x39, 0xfa, 0x1f, 0xe8, 0x94, 0x6a, 0x84, 0xd0, 0xcf, 0x1f, 0x7b, 0xee, 0xad, 0x17, 0x13, 0xe2, 0xe0, 0x95, 0x98, 0x97, 0x34, 0x7f, 0x67, 0xc8, 0x0b, 0x04, 0x00, 0xc2, 0x09, 0x81, 0x5d, 0x6b, 0x10, 0xa6, 0x83, 0x83, 0x6f, 0xd5, 0x56, 0x2a, 0x56, 0xca, 0xb1, 0xa2, 0x8e, 0x81, 0xb6, 0x57, 0x66, 0x54, 0x63, 0x1c, 0xf1, 0x65, 0x66, 0xb8, 0x6e, 0x3b, 0x33, 0xa1, 0x08, 0xb0, 0x53, 0x07, 0xc0, 0x0a, 0xff, 0x14, 0xa7, 0x68, 0xed, 0x73, 0x50, 0x60, 0x6a, 0x0f, 0x85, 0xe6, 0xa9, 0x1d, 0x39, 0x6f, 0x5b, 0x5c, 0xbe, 0x57, 0x7f, 0x9b, 0x38, 0x80, 0x7c, 0x7d, 0x52, 0x3d, 0x6d, 0x79, 0x2f, 0x6e, 0xbc, 0x24, 0xa4, 0xec, 0xf2, 0xb3, 0xa4, 0x27, 0xcd, 0xbb, 0xfb]

enum TestInput: StringLiteralConvertible, ArrayLiteralConvertible, Hashable {
    typealias StringLiteralType = String
    typealias UnicodeScalarLiteralType = StringLiteralType
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    typealias Element = UInt8

    case Text(String)
    case Bytes([UInt8])

    init(stringLiteral value: StringLiteralType) {
        self = .Text(value)
    }

    init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .Text(value)
    }

    init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .Text(value)
    }

    init(arrayLiteral elements: Element...) {
        self = .Bytes(elements)
    }

    var value: NSData {
        switch self {
        case .Text(let v):
            guard let result = v.dataUsingEncoding(NSUTF8StringEncoding) else {
                fatalError()
            }

            return result

        case .Bytes(let bytes):
            return NSData(bytes: bytes)
        }
    }

    var hashValue: Int {
        return value.hashValue
    }
}

func ==(lhs: TestInput, rhs: TestInput) -> Bool {
    return lhs.value.isEqualToData(rhs.value)
}

func beChecksum<T: CCHashAlgorithmProtocol>(expectedValue: String) -> MatcherFunc<T> {
    return MatcherFunc { actionExpression, failureMessage in
        return false
    }
}

protocol IETFMessageDigestSpec: class {
    associatedtype Algorithm
    var cases: [TestInput: String] { get }
    var algorithm: String { set get }
    var url: String { set get }
}

extension IETFMessageDigestSpec where Algorithm: CCHashAlgorithmProtocol {
    func testIETFTestSuite() {
        for (key, checksum) in cases {
            expect(Hash<Algorithm>(data: key.value).hexdigest) == checksum
        }
    }
}

class MD2Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = MD2
    var cases: [TestInput: String] = [
        "": "8350e5a3e24c153df2275c9f80692773",
        "a": "32ec01ec4a6dac72c0ab96fb34c0b5d1",
        "abc": "da853b0d3f88d99b30283a69e6ded6bb",
        "message digest": "ab4f496bfb2a530b219ff33031fe06b0",
        "abcdefghijklmnopqrstuvwxyz": "4e8ddff3650292ab5a4108c3aa47940b",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789": "da33def2a42df13975352846c30338cd",
        "12345678901234567890123456789012345678901234567890123456789012345678901234567890": "d5976f79d83d3a0dc9806c3c66f3efd8"
    ]
    var algorithm = "MD2"
    var url = "https://www.ietf.org/rfc/rfc1319.txt"

    func testExample() {
        testIETFTestSuite()
    }
}

class MD4Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = MD4
    var cases: [TestInput: String] = [
        "": "31d6cfe0d16ae931b73c59d7e0c089c0",
        "a": "bde52cb31de33e46245e05fbdbd6fb24",
        "abc": "a448017aaf21d8525fc10ae87aa6729d",
        "message digest": "d9130a8164549fe818874806e1c7014b",
        "abcdefghijklmnopqrstuvwxyz": "d79e1c308aa5bbcdeea8ed63df412da9",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789": "043f8582f241db351ce627e153e7f0e4",
        "12345678901234567890123456789012345678901234567890123456789012345678901234567890": "e33b4ddc9c38f2199c3e7b164fcc0536"
    ]
    var algorithm = "MD4"
    var url = "https://www.ietf.org/rfc/rfc1320.txt"

    func testExample() {
        testIETFTestSuite()
    }
}

class MD5Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = MD5
    var cases: [TestInput: String] = [
        "": "d41d8cd98f00b204e9800998ecf8427e",
        "a": "0cc175b9c0f1b6a831c399e269772661",
        "abc": "900150983cd24fb0d6963f7d28e17f72",
        "message digest": "f96b697d7cb7938d525a2f31aaf161d0",
        "abcdefghijklmnopqrstuvwxyz": "c3fcd3d76192e4007dfb496cca67e13b",
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789": "d174ab98d277d9f5a5611c2c9f419d9f",
        "12345678901234567890123456789012345678901234567890123456789012345678901234567890": "57edf4a22be3c955ac49da2e2107b67a",
    ]
    var algorithm = "MD5"
    var url = "https://www.ietf.org/rfc/rfc1321.txt"

    func testExample() {
        testIETFTestSuite()
    }
}

// TODO: Implement IETF Test Cases 5, 7, and 9
class SHA1Spec: XCTestCase, IETFMessageDigestSpec {
    static let TEST3 = String(count: 1000000, repeatedValue: Character("a"))
    static let TEST4 = Array(count: 10, repeatedValue: "0123456701234567012345670123456701234567012345670123456701234567").joinWithSeparator("")

    typealias Algorithm = SHA1
    var cases: [TestInput: String] = [
        .Text(TEST1): "a9993e364706816aba3e25717850c26c9cd0d89d",
        .Text(TEST2_1): "84983e441c3bd26ebaae4aa1f95129e5e54670f1",
        .Text(TEST3): "34aa973cd4c4daa4f61eeb2bdbad27316534016f",
        .Text(TEST4): "dea356a2cddd90c7a7ecedc5ebb563934f460452",
        [0x5e]: "5e6f80a34a9798cafc6a5db96cc57ba4c4db59c2",
        .Bytes(TEST8_1): "82abff6605dbe1c17def12a394fa22a82b544a35",
        .Bytes(TEST10_1): "cb0082c8f197d260991ba6a460e76e202bad27b3",
    ]
    var algorithm = "SHA1"
    var url = "https://tools.ietf.org/html/rfc6234#section-8.5"

    func testExample() {
        testIETFTestSuite()
    }
}

class SHA224Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = SHA224
    var cases: [TestInput: String] = [
        .Text(TEST1): "a9993e364706816aba3e25717850c26c9cd0d89d",
        .Text(TEST2_1): "84983e441c3bd26ebaae4aa1f95129e5e54670f1",
        .Text(TEST3): "34aa973cd4c4daa4f61eeb2bdbad27316534016f",
        .Text(TEST4): "dea356a2cddd90c7a7ecedc5ebb563934f460452",
        [0x5e]: "5e6f80a34a9798cafc6a5db96cc57ba4c4db59c2",
        .Bytes(TEST8_1): "82abff6605dbe1c17def12a394fa22a82b544a35",
        .Bytes(TEST10_1): "cb0082c8f197d260991ba6a460e76e202bad27b3",
        ]
    var algorithm = "SHA224"
    var url = "https://tools.ietf.org/html/rfc6234#section-8.5"
    
    func testExample() {
        testIETFTestSuite()
    }
}