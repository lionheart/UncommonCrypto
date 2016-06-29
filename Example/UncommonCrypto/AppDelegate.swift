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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        var hash = Hash<MD5>("message")
        do {
            try hash.update(" digest", textEncoding: NSASCIIStringEncoding)
        } catch ChecksumError.DataConversionError {
            // Uh oh.
        } catch {
            // Well, this is awkward.
        }
        print(hash)

        return true
    }
}
