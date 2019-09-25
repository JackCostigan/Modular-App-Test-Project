//
//  ModuleB.swift
//  ModuleB
//
//  Created by admin on 25/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ModuleKit

public class ModuleB<ViewControllerPresenter: PresenterProtocol>: ModuleProtocol
where ViewControllerPresenter.Presentable == UIViewController {
  public typealias Presenter = ViewControllerPresenter
  public typealias Delegate = BobInteractorInterface
  
  private let interactor: BobInteractor
  private let previousResult: String
  
  public init(previousResult: String) {
    self.interactor = BobInteractor()
    self.previousResult = previousResult
  }
  
  public var delegate: BobInteractorInterface? {
    get {
      return interactor.delegate
    }
    set {
      interactor.delegate = newValue
    }
  }
  
  public func start(with presenter: ViewControllerPresenter) {
    let _ = BobWireframe(interactor: interactor,
                         viewControllerPresenter: presenter,
                         previousResult: previousResult)
  }
}
