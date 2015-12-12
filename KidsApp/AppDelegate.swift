//
//  AppDelegate.swift
//  KidsApp
//
//  Created by Anna Goman on 19.08.15.
//  Copyright (c) 2015 Anna Goman. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  let storyboard = UIStoryboard(name: "Main", bundle: nil)
  var window: UIWindow?
  let dataStore = DataStore.sharedDataStore
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    let initialViewController: UIViewController
    if dataStore.users.count > 0 {
      initialViewController = storyboard.instantiateViewControllerWithIdentifier("MainNavigationVC") 
    } else {
      initialViewController = storyboard.instantiateViewControllerWithIdentifier("CreatePersonVC") 
    }
    window?.rootViewController = initialViewController
    window?.makeKeyAndVisible()
    
    // Override point for customization after application launch.
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    let (success, error) = dataContext.save()
    
    if !success {
      // Replace this implementation with code to handle the error appropriately.
      // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
      NSLog("Unresolved error \(error), \(error!.userInfo)")
      abort()
    }
    
  }
  
  func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask.All
  }
  
}

