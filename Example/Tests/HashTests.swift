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
let TEST7_224: [UInt8] = [0xf0, 0x70, 0x06, 0xf2, 0x5a, 0x0b, 0xea, 0x68, 0xcd, 0x76, 0xa2, 0x95, 0x87, 0xc2, 0x8d]
let TEST8_224: [UInt8] = [0x18, 0x80, 0x40, 0x05, 0xdd, 0x4f, 0xbd, 0x15, 0x56, 0x29, 0x9d, 0x6f, 0x9d, 0x93, 0xdf, 0x62]
let TEST9_224: [UInt8] = [0xa2, 0xbe, 0x6e, 0x46, 0x32, 0x81, 0x09, 0x02, 0x94, 0xd9, 0xce, 0x94, 0x82, 0x65, 0x69, 0x42, 0x3a, 0x3a, 0x30, 0x5e, 0xd5, 0xe2, 0x11, 0x6c, 0xd4, 0xa4, 0xc9, 0x87, 0xfc, 0x06, 0x57, 0x00, 0x64, 0x91, 0xb1, 0x49, 0xcc, 0xd4, 0xb5, 0x11, 0x30, 0xac, 0x62, 0xb1, 0x9d, 0xc2, 0x48, 0xc7, 0x44, 0x54, 0x3d, 0x20, 0xcd, 0x39, 0x52, 0xdc, 0xed, 0x1f, 0x06, 0xcc, 0x3b, 0x18, 0xb9, 0x1f, 0x3f, 0x55, 0x63, 0x3e, 0xcc, 0x30, 0x85, 0xf4, 0x90, 0x70, 0x60, 0xd2]
let TEST10_224: [UInt8] = [0x55, 0xb2, 0x10, 0x07, 0x9c, 0x61, 0xb5, 0x3a, 0xdd, 0x52, 0x06, 0x22, 0xd1, 0xac, 0x97, 0xd5, 0xcd, 0xbe, 0x8c, 0xb3, 0x3a, 0xa0, 0xae, 0x34, 0x45, 0x17, 0xbe, 0xe4, 0xd7, 0xba, 0x09, 0xab, 0xc8, 0x53, 0x3c, 0x52, 0x50, 0x88, 0x7a, 0x43, 0xbe, 0xbb, 0xac, 0x90, 0x6c, 0x2e, 0x18, 0x37, 0xf2, 0x6b, 0x36, 0xa5, 0x9a, 0xe3, 0xbe, 0x78, 0x14, 0xd5, 0x06, 0x89, 0x6b, 0x71, 0x8b, 0x2a, 0x38, 0x3e, 0xcd, 0xac, 0x16, 0xb9, 0x61, 0x25, 0x55, 0x3f, 0x41, 0x6f, 0xf3, 0x2c, 0x66, 0x74, 0xc7, 0x45, 0x99, 0xa9, 0x00, 0x53, 0x86, 0xd9, 0xce, 0x11, 0x12, 0x24, 0x5f, 0x48, 0xee, 0x47, 0x0d, 0x39, 0x6c, 0x1e, 0xd6, 0x3b, 0x92, 0x67, 0x0c, 0xa5, 0x6e, 0xc8, 0x4d, 0xee, 0xa8, 0x14, 0xb6, 0x13, 0x5e, 0xca, 0x54, 0x39, 0x2b, 0xde, 0xdb, 0x94, 0x89, 0xbc, 0x9b, 0x87, 0x5a, 0x8b, 0xaf, 0x0d, 0xc1, 0xae, 0x78, 0x57, 0x36, 0x91, 0x4a, 0xb7, 0xda, 0xa2, 0x64, 0xbc, 0x07, 0x9d, 0x26, 0x9f, 0x2c, 0x0d, 0x7e, 0xdd, 0xd8, 0x10, 0xa4, 0x26, 0x14, 0x5a, 0x07, 0x76, 0xf6, 0x7c, 0x87, 0x82, 0x73]
let TEST7_256: [UInt8] = [0xbe, 0x27, 0x46, 0xc6, 0xdb, 0x52, 0x76, 0x5f, 0xdb, 0x2f, 0x88, 0x70, 0x0f, 0x9a, 0x73]
let TEST8_256: [UInt8] = [0xe3, 0xd7, 0x25, 0x70, 0xdc, 0xdd, 0x78, 0x7c, 0xe3, 0x88, 0x7a, 0xb2, 0xcd, 0x68, 0x46, 0x52]
let TEST9_256: [UInt8] = [0x3e, 0x74, 0x03, 0x71, 0xc8, 0x10, 0xc2, 0xb9, 0x9f, 0xc0, 0x4e, 0x80, 0x49, 0x07, 0xef, 0x7c, 0xf2, 0x6b, 0xe2, 0x8b, 0x57, 0xcb, 0x58, 0xa3, 0xe2, 0xf3, 0xc0, 0x07, 0x16, 0x6e, 0x49, 0xc1, 0x2e, 0x9b, 0xa3, 0x4c, 0x01, 0x04, 0x06, 0x91, 0x29, 0xea, 0x76, 0x15, 0x64, 0x25, 0x45, 0x70, 0x3a, 0x2b, 0xd9, 0x01, 0xe1, 0x6e, 0xb0, 0xe0, 0x5d, 0xeb, 0xa0, 0x14, 0xeb, 0xff, 0x64, 0x06, 0xa0, 0x7d, 0x54, 0x36, 0x4e, 0xff, 0x74, 0x2d, 0xa7, 0x79, 0xb0, 0xb3]
let TEST10_256: [UInt8] = [0x83, 0x26, 0x75, 0x4e, 0x22, 0x77, 0x37, 0x2f, 0x4f, 0xc1, 0x2b, 0x20, 0x52, 0x7a, 0xfe, 0xf0, 0x4d, 0x8a, 0x05, 0x69, 0x71, 0xb1, 0x1a, 0xd5, 0x71, 0x23, 0xa7, 0xc1, 0x37, 0x76, 0x00, 0x00, 0xd7, 0xbe, 0xf6, 0xf3, 0xc1, 0xf7, 0xa9, 0x08, 0x3a, 0xa3, 0x9d, 0x81, 0x0d, 0xb3, 0x10, 0x77, 0x7d, 0xab, 0x8b, 0x1e, 0x7f, 0x02, 0xb8, 0x4a, 0x26, 0xc7, 0x73, 0x32, 0x5f, 0x8b, 0x23, 0x74, 0xde, 0x7a, 0x4b, 0x5a, 0x58, 0xcb, 0x5c, 0x5c, 0xf3, 0x5b, 0xce, 0xe6, 0xfb, 0x94, 0x6e, 0x5b, 0xd6, 0x94, 0xfa, 0x59, 0x3a, 0x8b, 0xeb, 0x3f, 0x9d, 0x65, 0x92, 0xec, 0xed, 0xaa, 0x66, 0xca, 0x82, 0xa2, 0x9d, 0x0c, 0x51, 0xbc, 0xf9, 0x33, 0x62, 0x30, 0xe5, 0xd7, 0x84, 0xe4, 0xc0, 0xa4, 0x3f, 0x8d, 0x79, 0xa3, 0x0a, 0x16, 0x5c, 0xba, 0xbe, 0x45, 0x2b, 0x77, 0x4b, 0x9c, 0x71, 0x09, 0xa9, 0x7d, 0x13, 0x8f, 0x12, 0x92, 0x28, 0x96, 0x6f, 0x6c, 0x0a, 0xdc, 0x10, 0x6a, 0xad, 0x5a, 0x9f, 0xdd, 0x30, 0x82, 0x57, 0x69, 0xb2, 0xc6, 0x71, 0xaf, 0x67, 0x59, 0xdf, 0x28, 0xeb, 0x39, 0x3d, 0x54, 0xd6]
let TEST7_384: [UInt8] = [0x8b, 0xc5, 0x00, 0xc7, 0x7c, 0xee, 0xd9, 0x87, 0x9d, 0xa9, 0x89, 0x10, 0x7c, 0xe0, 0xaa]
let TEST8_384: [UInt8] = [0xa4, 0x1c, 0x49, 0x77, 0x79, 0xc0, 0x37, 0x5f, 0xf1, 0x0a, 0x7f, 0x4e, 0x08, 0x59, 0x17, 0x39]
let TEST9_384: [UInt8] = [0x68, 0xf5, 0x01, 0x79, 0x2d, 0xea, 0x97, 0x96, 0x76, 0x70, 0x22, 0xd9, 0x3d, 0xa7, 0x16, 0x79, 0x30, 0x99, 0x20, 0xfa, 0x10, 0x12, 0xae, 0xa3, 0x57, 0xb2, 0xb1, 0x33, 0x1d, 0x40, 0xa1, 0xd0, 0x3c, 0x41, 0xc2, 0x40, 0xb3, 0xc9, 0xa7, 0x5b, 0x48, 0x92, 0xf4, 0xc0, 0x72, 0x4b, 0x68, 0xc8, 0x75, 0x32, 0x1a, 0xb8, 0xcf, 0xe5, 0x02, 0x3b, 0xd3, 0x75, 0xbc, 0x0f, 0x94, 0xbd, 0x89, 0xfe, 0x04, 0xf2, 0x97, 0x10, 0x5d, 0x7b, 0x82, 0xff, 0xc0, 0x02, 0x1a, 0xeb, 0x1c, 0xcb, 0x67, 0x4f, 0x52, 0x44, 0xea, 0x34, 0x97, 0xde, 0x26, 0xa4, 0x19, 0x1c, 0x5f, 0x62, 0xe5, 0xe9, 0xa2, 0xd8, 0x08, 0x2f, 0x05, 0x51, 0xf4, 0xa5, 0x30, 0x68, 0x26, 0xe9, 0x1c, 0xc0, 0x06, 0xce, 0x1b, 0xf6, 0x0f, 0xf7, 0x19, 0xd4, 0x2f, 0xa5, 0x21, 0xc8, 0x71, 0xcd, 0x23, 0x94, 0xd9, 0x6e, 0xf4, 0x46, 0x8f, 0x21, 0x96, 0x6b, 0x41, 0xf2, 0xba, 0x80, 0xc2, 0x6e, 0x83, 0xa9]
let TEST10_384: [UInt8] = [0x39, 0x96, 0x69, 0xe2, 0x8f, 0x6b, 0x9c, 0x6d, 0xbc, 0xbb, 0x69, 0x12, 0xec, 0x10, 0xff, 0xcf, 0x74, 0x79, 0x03, 0x49, 0xb7, 0xdc, 0x8f, 0xbe, 0x4a, 0x8e, 0x7b, 0x3b, 0x56, 0x21, 0xdb, 0x0f, 0x3e, 0x7d, 0xc8, 0x7f, 0x82, 0x32, 0x64, 0xbb, 0xe4, 0x0d, 0x18, 0x11, 0xc9, 0xea, 0x20, 0x61, 0xe1, 0xc8, 0x4a, 0xd1, 0x0a, 0x23, 0xfa, 0xc1, 0x72, 0x7e, 0x72, 0x02, 0xfc, 0x3f, 0x50, 0x42, 0xe6, 0xbf, 0x58, 0xcb, 0xa8, 0xa2, 0x74, 0x6e, 0x1f, 0x64, 0xf9, 0xb9, 0xea, 0x35, 0x2c, 0x71, 0x15, 0x07, 0x05, 0x3c, 0xf4, 0xe5, 0x33, 0x9d, 0x52, 0x86, 0x5f, 0x25, 0xcc, 0x22, 0xb5, 0xe8, 0x77, 0x84, 0xa1, 0x2f, 0xc9, 0x61, 0xd6, 0x6c, 0xb6, 0xe8, 0x95, 0x73, 0x19, 0x9a, 0x2c, 0xe6, 0x56, 0x5c, 0xbd, 0xf1, 0x3d, 0xca, 0x40, 0x38, 0x32, 0xcf, 0xcb, 0x0e, 0x8b, 0x72, 0x11, 0xe8, 0x3a, 0xf3, 0x2a, 0x11, 0xac, 0x17, 0x92, 0x9f, 0xf1, 0xc0, 0x73, 0xa5, 0x1c, 0xc0, 0x27, 0xaa, 0xed, 0xef, 0xf8, 0x5a, 0xad, 0x7c, 0x2b, 0x7c, 0x5a, 0x80, 0x3e, 0x24, 0x04, 0xd9, 0x6d, 0x2a, 0x77, 0x35, 0x7b, 0xda, 0x1a, 0x6d, 0xae, 0xed, 0x17, 0x15, 0x1c, 0xb9, 0xbc, 0x51, 0x25, 0xa4, 0x22, 0xe9, 0x41, 0xde, 0x0c, 0xa0, 0xfc, 0x50, 0x11, 0xc2, 0x3e, 0xcf, 0xfe, 0xfd, 0xd0, 0x96, 0x76, 0x71, 0x1c, 0xf3, 0xdb, 0x0a, 0x34, 0x40, 0x72, 0x0e, 0x16, 0x15, 0xc1, 0xf2, 0x2f, 0xbc, 0x3c, 0x72, 0x1d, 0xe5, 0x21, 0xe1, 0xb9, 0x9b, 0xa1, 0xbd, 0x55, 0x77, 0x40, 0x86, 0x42, 0x14, 0x7e, 0xd0, 0x96]
let TEST7_512: [UInt8] = [0x08, 0xec, 0xb5, 0x2e, 0xba, 0xe1, 0xf7, 0x42, 0x2d, 0xb6, 0x2b, 0xcd, 0x54, 0x26, 0x70]
let TEST8_512: [UInt8] = [0x8d, 0x4e, 0x3c, 0x0e, 0x38, 0x89, 0x19, 0x14, 0x91, 0x81, 0x6e, 0x9d, 0x98, 0xbf, 0xf0, 0xa0]
let TEST9_512: [UInt8] = [0x3a, 0xdd, 0xec, 0x85, 0x59, 0x32, 0x16, 0xd1, 0x61, 0x9a, 0xa0, 0x2d, 0x97, 0x56, 0x97, 0x0b, 0xfc, 0x70, 0xac, 0xe2, 0x74, 0x4f, 0x7c, 0x6b, 0x27, 0x88, 0x15, 0x10, 0x28, 0xf7, 0xb6, 0xa2, 0x55, 0x0f, 0xd7, 0x4a, 0x7e, 0x6e, 0x69, 0xc2, 0xc9, 0xb4, 0x5f, 0xc4, 0x54, 0x96, 0x6d, 0xc3, 0x1d, 0x2e, 0x10, 0xda, 0x1f, 0x95, 0xce, 0x02, 0xbe, 0xb4, 0xbf, 0x87, 0x65, 0x57, 0x4c, 0xbd, 0x6e, 0x83, 0x37, 0xef, 0x42, 0x0a, 0xdc, 0x98, 0xc1, 0x5c, 0xb6, 0xd5, 0xe4, 0xa0, 0x24, 0x1b, 0xa0, 0x04, 0x6d, 0x25, 0x0e, 0x51, 0x02, 0x31, 0xca, 0xc2, 0x04, 0x6c, 0x99, 0x16, 0x06, 0xab, 0x4e, 0xe4, 0x14, 0x5b, 0xee, 0x2f, 0xf4, 0xbb, 0x12, 0x3a, 0xab, 0x49, 0x8d, 0x9d, 0x44, 0x79, 0x4f, 0x99, 0xcc, 0xad, 0x89, 0xa9, 0xa1, 0x62, 0x12, 0x59, 0xed, 0xa7, 0x0a, 0x5b, 0x6d, 0xd4, 0xbd, 0xd8, 0x77, 0x78, 0xc9, 0x04, 0x3b, 0x93, 0x84, 0xf5, 0x49, 0x06]
let TEST10_512: [UInt8] = [0xa5, 0x5f, 0x20, 0xc4, 0x11, 0xaa, 0xd1, 0x32, 0x80, 0x7a, 0x50, 0x2d, 0x65, 0x82, 0x4e, 0x31, 0xa2, 0x30, 0x54, 0x32, 0xaa, 0x3d, 0x06, 0xd3, 0xe2, 0x82, 0xa8, 0xd8, 0x4e, 0x0d, 0xe1, 0xde, 0x69, 0x74, 0xbf, 0x49, 0x54, 0x69, 0xfc, 0x7f, 0x33, 0x8f, 0x80, 0x54, 0xd5, 0x8c, 0x26, 0xc4, 0x93, 0x60, 0xc3, 0xe8, 0x7a, 0xf5, 0x65, 0x23, 0xac, 0xf6, 0xd8, 0x9d, 0x03, 0xe5, 0x6f, 0xf2, 0xf8, 0x68, 0x00, 0x2b, 0xc3, 0xe4, 0x31, 0xed, 0xc4, 0x4d, 0xf2, 0xf0, 0x22, 0x3d, 0x4b, 0xb3, 0xb2, 0x43, 0x58, 0x6e, 0x1a, 0x7d, 0x92, 0x49, 0x36, 0x69, 0x4f, 0xcb, 0xba, 0xf8, 0x8d, 0x95, 0x19, 0xe4, 0xeb, 0x50, 0xa6, 0x44, 0xf8, 0xe4, 0xf9, 0x5e, 0xb0, 0xea, 0x95, 0xbc, 0x44, 0x65, 0xc8, 0x82, 0x1a, 0xac, 0xd2, 0xfe, 0x15, 0xab, 0x49, 0x81, 0x16, 0x4b, 0xbb, 0x6d, 0xc3, 0x2f, 0x96, 0x90, 0x87, 0xa1, 0x45, 0xb0, 0xd9, 0xcc, 0x9c, 0x67, 0xc2, 0x2b, 0x76, 0x32, 0x99, 0x41, 0x9c, 0xc4, 0x12, 0x8b, 0xe9, 0xa0, 0x77, 0xb3, 0xac, 0xe6, 0x34, 0x06, 0x4e, 0x6d, 0x99, 0x28, 0x35, 0x13, 0xdc, 0x06, 0xe7, 0x51, 0x5d, 0x0d, 0x73, 0x13, 0x2e, 0x9a, 0x0d, 0xc6, 0xd3, 0xb1, 0xf8, 0xb2, 0x46, 0xf1, 0xa9, 0x8a, 0x3f, 0xc7, 0x29, 0x41, 0xb1, 0xe3, 0xbb, 0x20, 0x98, 0xe8, 0xbf, 0x16, 0xf2, 0x68, 0xd6, 0x4f, 0x0b, 0x0f, 0x47, 0x07, 0xfe, 0x1e, 0xa1, 0xa1, 0x79, 0x1b, 0xa2, 0xf3, 0xc0, 0xc7, 0x58, 0xe5, 0xf5, 0x51, 0x86, 0x3a, 0x96, 0xc9, 0x49, 0xad, 0x47, 0xd7, 0xfb, 0x40, 0xd2]

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
    var url = "https://tools.ietf.org/html/rfc1319#appendix-A.5"

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
    var url = "https://tools.ietf.org/html/rfc1320#appendix-A.5"

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
    var url = "https://tools.ietf.org/html/rfc1321#appendix-A.5"

    func testExample() {
        testIETFTestSuite()
    }
}

// TODO: Implement IETF Test Cases 5, 7, and 9
class SHA1Spec: XCTestCase, IETFMessageDigestSpec {
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

// TODO: Implement IETF Test Cases 5, 7, and 9
class SHA224Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = SHA224
    var cases: [TestInput: String] = [
        .Text(TEST1): "23097d223405d8228642a477bda255b32aadbce4bda0b3f7e36c9da7",
        .Text(TEST2_1): "75388b16512776cc5dba5da1fd890150b0c6455cb4f58b1952522525",
        .Text(TEST3): "20794655980c91d8bbb4c1ea97618a4bf03f42581948b2ee4ee7ad67",
        .Text(TEST4): "567f69f168cd7844e65259ce658fe7aadfa25216e68eca0eb7ab8262",
        [0x07]: "00ecd5f138422b8ad74c9799fd826c531bad2fcabc7450bee2aa8c2a",
        .Bytes(TEST8_224): "df90d78aa78821c99b40ba4c966921accd8ffb1e98ac388e56191db1",
        .Bytes(TEST10_224): "0b31894ec8937ad9b91bdfbcba294d9adefaa18e09305e9f20d5c3a4",
    ]
    var algorithm = "SHA224"
    var url = "https://tools.ietf.org/html/rfc6234#section-8.5"

    func testExample() {
        testIETFTestSuite()
    }
}

// TODO: Implement IETF Test Cases 5, 7, and 9
class SHA256Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = SHA256
    var cases: [TestInput: String] = [
        .Text(TEST1): "ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad",
        .Text(TEST2_1): "248d6a61d20638b8e5c026930c3e6039a33ce45964ff2167f6ecedd419db06c1",
        .Text(TEST3): "cdc76e5c9914fb9281a1c7e284d73e67f1809a48a497200e046d39ccc7112cd0",
        .Text(TEST4): "594847328451bdfa85056225462cc1d867d877fb388df0ce35f25ab5562bfbb5",
        [0x19]: "68aa2e2ee5dff96e3355e6c7ee373e3d6a4e17f75f9518d843709c0c9bc3e3d4",
        .Bytes(TEST8_256): "175ee69b02ba9b58e2b0a5fd13819cea573f3940a94f825128cf4209beabb4e8",
        .Bytes(TEST10_256): "97dbca7df46d62c8a422c941dd7e835b8ad3361763f7e9b2d95f4f0da6e1ccbc",
    ]
    var algorithm = "SHA256"
    var url = "https://tools.ietf.org/html/rfc6234#section-8.5"

    func testExample() {
        testIETFTestSuite()
    }
}

// TODO: Implement IETF Test Cases 5, 7, and 9
class SHA384Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = SHA384
    var cases: [TestInput: String] = [
        .Text(TEST1): "cb00753f45a35e8bb5a03d699ac65007272c32ab0eded1631a8b605a43ff5bed8086072ba1e7cc2358baeca134c825a7",
        .Text(TEST2_2): "09330c33f71147e83d192fc782cd1b4753111b173b3b05d22fa08086e3b0f712fcc7c71a557e2db966c3e9fa91746039",
        .Text(TEST3): "9d0e1809716474cb086e834e310a4a1ced149e9c00f248527972cec5704c2a5b07b8b3dc38ecc4ebae97ddd87f3d8985",
        .Text(TEST4): "2fc64a4f500ddb6828f6a3430b8dd72a368eb7f3a8322a70bc84275b9c0b3ab00d27a5cc3c2d224aa6b61a0d79fb4596",
        [0xb9]: "bc8089a19007c0b14195f4ecc74094fec64f01f90929282c2fb392881578208ad466828b1c6c283d2722cf0ad1ab6938",
        .Bytes(TEST8_384): "c9a68443a005812256b8ec76b00516f0dbb74fab26d665913f194b6ffb0e91ea9967566b58109cbc675cc208e4c823f7",
        .Bytes(TEST10_384): "4f440db1e6edd2899fa335f09515aa025ee177a79f4b4aaf38e42b5c4de660f5de8fb2a5b2fbd2a3cbffd20cff1288c0",
    ]
    var algorithm = "SHA384"
    var url = "https://tools.ietf.org/html/rfc6234#section-8.5"

    func testExample() {
        testIETFTestSuite()
    }
}

// TODO: Implement IETF Test Cases 5, 7, and 9
class SHA512Spec: XCTestCase, IETFMessageDigestSpec {
    typealias Algorithm = SHA512
    var cases: [TestInput: String] = [
        .Text(TEST1): "ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f",
        .Text(TEST2_2): "8e959b75dae313da8cf4f72814fc143f8f7779c6eb9f7fa17299aeadb6889018501d289e4900f7e4331b99dec4b5433ac7d329eeb6dd26545e96e55b874be909",
        .Text(TEST3): "e718483d0ce769644e2e42c7bc15b4638e1f98b13b2044285632a803afa973ebde0ff244877ea60a4cb0432ce577c31beb009c5c2c49aa2e4eadb217ad8cc09b",
        .Text(TEST4): "89d05ba632c699c31231ded4ffc127d5a894dad412c0e024db872d1abd2ba8141a0f85072a9be1e2aa04cf33c765cb510813a39cd5a84c4acaa64d3f3fb7bae9",
        [0xD0]: "9992202938e882e73e20f6b69e68a0a7149090423d93c81bab3f21678d4aceeee50e4e8cafada4c85a54ea8306826c4ad6e74cece9631bfa8a549b4ab3fbba15",
        .Bytes(TEST8_512): "cb0b67a4b8712cd73c9aabc0b199e9269b20844afb75acbdd1c153c9828924c3ddedaafe669c5fdd0bc66f630f6773988213eb1b16f517ad0de4b2f0c95c90f8",
        .Bytes(TEST10_512): "c665befb36da189d78822d10528cbf3b12b3eef726039909c1a16a270d48719377966b957a878e720584779a62825c18da26415e49a7176a894e7510fd1451f5",
    ]
    var algorithm = "SHA512"
    var url = "https://tools.ietf.org/html/rfc6234#section-8.5"

    func testExample() {
        testIETFTestSuite()
    }
}