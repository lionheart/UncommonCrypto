//
//  HmacTests.swift
//  UncommonCrypto
//
//  Created by Daniel Loewenherz on 6/29/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import UncommonCrypto

var cases: [(String, Data, (String, String, String, String, String))] = [(
    "0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b0b",
    Data(hexString: "4869205468657265"), // Hi There
    (
        "B617318655057264E28BC0B6FB378C8EF146BE00",
        "896FB1128ABBDF196832107CD49DF33F47B4B1169912BA4F53684B22",
        "B0344C61D8DB38535CA8AFCEAF0BF12B881DC200C9833DA726E9376C2E32CFF7",
        "AFD03944D84895626B0825F4AB46907F15F9DADBE4101EC682AA034C7CEBC59CFAEA9EA9076EDE7F4AF152E8B2FA9CB6",
        "87AA7CDEA5EF619D4FF0B4241A1D6CB02379F4E2CE4EC2787AD0B30545E17CDEDAA833B7D6B8A702038B274EAEA3F4E4BE9D914EEB61F1702E696C203A126854"
    )
    ),(
        "4a656665", // Jefe
        Data(hexString: "7768617420646f2079612077616e7420666f72206e6f7468696e673f"), // what do ya want for nothing?
        (
            "EFFCDF6AE5EB2FA2D27416D5F184DF9C259A7C79",
            "A30E01098BC6DBBF45690F3A7E9E6D0F8BBEA2A39E6148008FD05E44",
            "5BDCC146BF60754E6A042426089575C75A003F089D2739839DEC58B964EC3843",
            "AF45D2E376484031617F78D2B58A6B1B9C7EF464F5A01B47E42EC3736322445E8E2240CA5E69E2C78B3239ECFAB21649",
            "164B7A7BFCF819E2E395FBE73B56E0A387BD64222E831FD610270CD7EA2505549758BF75C05A994A6D034F65F8F0E6FDCAEAB1A34D4A6B4B636E070A38BCE737"
        )
    ),
      (
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        Data(hexString: "dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd"),
        (
            "125D7342B9AC11CD91A39AF48AA17B4F63F175D3",
            "7FB3CB3588C6C1F6FFA9694D7D6AD2649365B0C1F65D69D1EC8333EA",
            "773EA91E36800E46854DB8EBD09181A72959098B3EF8C122D9635514CED565FE",
            "88062608D3E6AD8A0AA2ACE014C8A86F0AA635D947AC9FEBE83EF4E55966144B2A5AB39DC13814B94E3AB6E101A34F27",
            "FA73B0089D56A284EFB0F0756C890BE9B1B5DBDD8EE81A3655F83E33B2279D39BF3E848279A722C806B485A47E67C807B946A337BEE8942674278859E13292FB"
        )
    ),
      (
        "0102030405060708090a0b0c0d0e0f10111213141516171819",
        Data(hexString: "cdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcdcd"),
        (
            "4C9007F4026250C6BC8414F9BF50C86C2D7235DA",
            "6C11506874013CAC6A2ABC1BB382627CEC6A90D86EFC012DE7AFEC5A",
            "82558A389A443C0EA4CC819899F2083A85F0FAA3E578F8077A2E3FF46729665B",
            "3E8A69B7783C25851933AB6290AF6CA77A9981480850009CC5577C6E1F573B4E6801DD23C4A7D679CCF8A386C674CFFB",
            "B0BA465637458C6990E5A8C5F61D4AF7E576D97FF94B872DE76F8050361EE3DBA91CA5C11AA25EB4D679275CC5788063A5F19741120C4F2DE2ADEBEB10A298DD"
        )
)]

/**
 HMAC-SHA1 Spec

 - seealso: https://tools.ietf.org/html/rfc6234#section-8.5
 */
class HmacSHA1Spec: XCTestCase {
    func testAllCases() {
        for c in cases {
            let key = Data(hexString: c.0)
            let message = c.1
            expect(Hmac<SHA1>(key: key, message: message).hexdigest) == c.2.0.lowercased()
            expect(Hmac<SHA224>(key: key, message: message).hexdigest) == c.2.1.lowercased()
            expect(Hmac<SHA256>(key: key, message: message).hexdigest) == c.2.2.lowercased()
            expect(Hmac<SHA384>(key: key, message: message).hexdigest) == c.2.3.lowercased()
            expect(Hmac<SHA512>(key: key, message: message).hexdigest) == c.2.4.lowercased()
        }
    }
}
