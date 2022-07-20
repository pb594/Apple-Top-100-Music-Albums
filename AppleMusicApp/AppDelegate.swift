//
//  AppDelegate.swift
//  AppleMusicApp
//
//  Created by dedicated developer on 18/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    let appCoordinator = AppCoordinator()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()
        //Intialising App Coordinator for the Coordinator Design pattern
        appCoordinator.start()
        
        return true
    }
    
    class func sharedDelegate() -> AppDelegate{
        return UIApplication.shared.delegate as! AppDelegate
    }



}

