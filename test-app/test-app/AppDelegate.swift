//
//  AppDelegate.swift
//  test-app
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import ModuleA
import ModuleB
import ModuleKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var presenter: NavigationPresenter!

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    self.presenter = NavigationPresenter()
    presenter.animated = false
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = presenter.nav
    self.window?.makeKeyAndVisible()
    let flow = ModuleA<NavigationPresenter>().goesTo(ModuleB().inputTransformer { "\($0)" })
    flow.delegate = { input in flow.start(with: self.presenter, and: input) }
    flow.start(with: presenter, and: "")
    presenter.animated = true
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }


}

extension AppDelegate {
  func moduleAReturned(_ num: Int) {
    print("Number returned from module A: \(num)")
    let previousResult = "\(num)"
    let moduleB = ModuleB<NavigationPresenter>()
    moduleB.delegate = self.moduleBReturned
    moduleB.start(with: self.presenter, and: previousResult)
  }
}

extension AppDelegate {
  func moduleBReturned(_ text: String) {
    print("Text returned from module B: \(text)")
    let moduleA = ModuleA<NavigationPresenter>()
    moduleA.delegate = self.moduleAReturned
    moduleA.start(with: self.presenter, and: text)
  }
}
