//
//  NavigationPresenter.swift
//  test-app
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ModuleKit

class NavigationPresenter: PresenterProtocol {
  typealias Presentable = UIViewController
  
  let nav: UINavigationController
  var animated: Bool = true
  
  init(navigationController: UINavigationController = UINavigationController()) {
    self.nav = navigationController
  }
  
  func present(_ presentable: UIViewController) {
    nav.pushViewController(presentable, animated: animated)
  }
}
