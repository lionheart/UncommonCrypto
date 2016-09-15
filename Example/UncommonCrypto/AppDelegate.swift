//
//  AppDelegate.swift
//  UncommonCrypto
//
//  Created by Dan Loewenherz on 06/25/2016.
//  Copyright (c) 2016 Dan Loewenherz. All rights reserved.
//

import UIKit
import UncommonCrypto

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        // Override point for customization after application launch.

        let hash = Hmac<MD5>(key: "", message: "")
        print(hash.base64)

//        let data: (Data, Data) = try! PBKDF2<DES, SHA1>.key(password: "test", saltLength: 8, keySize: .Default) { $0 }

        Hash<MD5>("hey").hexdigest

        for i in 0..<100 {
            print(Random<Int>.generate(0..<1))
        }
        return true
    }
}
