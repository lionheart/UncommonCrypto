//
//  AppDelegate.swift
//  UncommonCrypto
//
//  Created by Dan Loewenherz on 06/25/2016.
//  Copyright (c) 2016 Dan Loewenherz. All rights reserved.
//

import UIKit
import UncommonCrypto
import ZLib

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        let data = NSData(hexString: "b8dfb080bc33fb564249e34252bf143d88fc018f")
        let h = Hash<SHA1>(input: "testing 123")
        print(h.hexdigest)
//        let key = try! PBKDF2<AES128, SHA1>.key(password: "test", saltLeng) { $0.key }
//        let x = Cryptor<AES128>(input: NSData(bytes: key))
//        let result: [UInt8] = try! x.encrypt(data: "hey".dataUsingEncoding(NSUTF8StringEncoding)!)

        let d = "testing 123".dataUsingEncoding(NSUTF8StringEncoding)!

        var digest = "abc".MD2
        digest.update("abc")
        print(digest.digest)
        let r = try! Random<String>.generate()

        return true
    }
}
