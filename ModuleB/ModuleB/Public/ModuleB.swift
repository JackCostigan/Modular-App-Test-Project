//
//  ModuleB.swift
//  ModuleB
//
//  Created by admin on 25/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ModuleKit

public class ModuleB<ViewControllerPresenter: RouterProtocol>: CompleteableModuleProtocol
where ViewControllerPresenter.Presentable == UIViewController {
  public typealias Presenter = ViewControllerPresenter
  public typealias Delegate = (String) -> Void
  public typealias Result = String
  public typealias Dependencies = String
  
  private let interactor: BobInteractor
  
  public init() {
    self.interactor = BobInteractor()
  }
  
  public var delegate: ((String) -> Void)? {
    get {
      return interactor.delegate
    }
    set {
      print("ModuleB delegate was set")
      interactor.delegate = newValue
    }
  }
  
  public func start(with presenter: ViewControllerPresenter, and previousResult: String) {
    let _ = BobWireframe(interactor: interactor,
                         viewControllerPresenter: presenter,
                         previousResult: previousResult)
  }
}
