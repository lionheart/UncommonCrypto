//
//  NSData+CRC32.h
//  UncommonCrypto
//
//  Created by Daniel Loewenherz on 6/27/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (CRC32)
- (uint32_t)CRC32Value;
@end