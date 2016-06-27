//
//  NSData+CRC32.m
//  UncommonCrypto
//
//  Created by Daniel Loewenherz on 6/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#import "NSData+CRC32.h"

@import ZLib;

@implementation NSData (CRC32)
- (uint32_t)CRC32Value {
    uLong crc = crc32(0L, Z_NULL, 0);
    crc = crc32(crc, [self bytes], [self length]);
    return crc;
}
@end