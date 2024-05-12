//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Darina Kovtun on 09.04.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            let tabBar = TabBarController()
            window.rootViewController = tabBar
            window.makeKeyAndVisible()
        }

        updateAppTransportSecuritySettings()

        return true
    }
    
    func updateAppTransportSecuritySettings() {
        guard let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            var plistDict = NSMutableDictionary(contentsOfFile: plistPath) as? [String: Any] else {
                fatalError("Could not load Info.plist")
        }

        var appTransportSecurityDict = plistDict["NSAppTransportSecurity"] as? [String: Any] ?? [:]
        var exceptionDomainsDict = appTransportSecurityDict["NSExceptionDomains"] as? [String: Any] ?? [:]

        exceptionDomainsDict["arizonasports.com"] = [
            "NSIncludesSubdomains": true,
            "NSTemporaryExceptionAllowsInsecureHTTPLoads": true
        ]

        appTransportSecurityDict["NSExceptionDomains"] = exceptionDomainsDict
        plistDict["NSAppTransportSecurity"] = appTransportSecurityDict

        let success = (plistDict as NSDictionary).write(toFile: plistPath, atomically: true)
        if !success {
            fatalError("Failed to write Info.plist")
        }
    }

}


