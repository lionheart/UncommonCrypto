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

        let h = Hash<SHA1>(text: "testing 123")
        print(h.hexdigest)

        let d = "testing 123".dataUsingEncoding(NSUTF8StringEncoding)!

        var digest = "abc".MD2
        digest.update("abc")
        print(digest.digest)
        let r = try! Random<String>.generate()

        return true
    }
}

