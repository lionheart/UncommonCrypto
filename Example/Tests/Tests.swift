// https://github.com/Quick/Quick

import Quick
import Nimble
@testable import UncommonCrypto

protocol IETFMessageDigestSpec: class {
    associatedtype Algorithm
    var cases: [String: String] { get }
    var algorithm: String { set get }
    var url: String { set get }
}

extension IETFMessageDigestSpec where Algorithm: CCHashAlgorithmProtocol {
    func hexdigest(text: String) -> String {
        return Hash<Algorithm>(text: text)!.hexdigest
    }

    func test() {
        describe(algorithm) {
            it("passes IETF test suite") {
                for (key, checksum) in self.cases {
                    expect(self.hexdigest(key)) == checksum
                }
            }
        }
    }
}

class MD4Spec: QuickSpec, IETFMessageDigestSpec {
    typealias Algorithm = MD4
    var cases = [
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

    override func spec() { test() }
}

class MD5Spec: QuickSpec {
    override func spec() {
        describe("MD5") {
            it("passes IETF test suite") {
                // See https://www.ietf.org/rfc/rfc1321.txt
                expect("".MD5!.hexdigest) == "d41d8cd98f00b204e9800998ecf8427e"
                expect("a".MD5!.hexdigest) == "0cc175b9c0f1b6a831c399e269772661"
                expect("abc".MD5!.hexdigest) == "900150983cd24fb0d6963f7d28e17f72"
                expect("message digest".MD5!.hexdigest) == "f96b697d7cb7938d525a2f31aaf161d0"
                expect("abcdefghijklmnopqrstuvwxyz".MD5!.hexdigest) == "c3fcd3d76192e4007dfb496cca67e13b"
                expect("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".MD5!.hexdigest) == "d174ab98d277d9f5a5611c2c9f419d9f"
                expect("12345678901234567890123456789012345678901234567890123456789012345678901234567890".MD5!.hexdigest) == "57edf4a22be3c955ac49da2e2107b67a"
            }
        }
    }
}
