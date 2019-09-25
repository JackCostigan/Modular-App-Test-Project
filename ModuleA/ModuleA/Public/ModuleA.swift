//
//  Interface.swift
//  ModuleA
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ModuleKit
import ReSwift

public class ModuleA<ViewControllerPresenter: PresenterProtocol>: ModuleProtocol
where ViewControllerPresenter.Presentable == UIViewController {
  public typealias Presenter = ViewControllerPresenter
  public typealias Delegate = ModuleADelegate
  
  let store: Store<Alice.State>
  let storyboard: UIStoryboard
  let delegateHandler: Alice.DelegateHandler
  
  public convenience init(text: String = "") {
    let delegateHandler = Alice.DelegateHandler()
    let store = Store<Alice.State>(reducer: Alice.reducer, state: Alice.State(text: text), middleware: [delegateHandler.middleware])
    let storyboard = UIStoryboard(name: "Alice", bundle: Bundle(for: AliceViewController.self))
    self.init(store: store, storyboard: storyboard, delegateHandler: delegateHandler)
  }
  
  // I would like to make this initializer public, with default parameters for
  // each value, but to do that I have to expose Alice.State, which maybe is fine?
  // For now I'm trying to avoid exposing any of the Redux abstractions.
  init(store: Store<Alice.State>, storyboard: UIStoryboard, delegateHandler: Alice.DelegateHandler) {
    self.store = store
    self.storyboard = storyboard
    self.delegateHandler = delegateHandler
  }
  
  public func start(with presenter: ViewControllerPresenter) {
    let vc = storyboard.instantiateViewController(withIdentifier: AliceViewController.identifier) as! AliceViewController
    vc.store = store
    presenter.present(vc)
  }
  
  public weak var delegate: ModuleADelegate? {
    get {
      return self.delegateHandler.delegate
    }
    set {
      self.delegateHandler.delegate = newValue
    }
  }
}

public protocol ModuleADelegate: class {
  func numberReturned(_: Int)
}

private extension UIStoryboard {
  static var `default` = UIStoryboard(name: "Alice", bundle: Bundle(for: AliceViewController.self))
}
