//
//  AppDelegate.swift
//  Weather
//
//  Created by Михаил Егоров on 15.12.2020.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions:
      [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     FirebaseApp.configure()
     return true
   }
}

