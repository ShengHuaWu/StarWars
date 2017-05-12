//
//  AppDelegate.swift
//  StarWars
//
//  Created by ShengHua Wu on 11/05/2017.
//  Copyright © 2017 ShengHua Wu. All rights reserved.
//

import UIKit
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let filmListVC = FilmListViewController()
        let navigationController = UINavigationController(rootViewController: filmListVC)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

