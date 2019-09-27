//
//  ModuleProtocol.swift
//  FlowController
//
//  Created by admin on 25/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

public protocol ModuleProtocol {
  associatedtype Delegate
  associatedtype Presenter: PresenterProtocol
  associatedtype Dependencies
  
  func start(with presenter: Presenter, and dependencies: Dependencies)
  var delegate: Delegate? { get set }
}

public protocol CompleteableModuleProtocol: ModuleProtocol where Delegate == (Result) -> Void {
  associatedtype Result
}

public class Flow<First: CompleteableModuleProtocol, Second: CompleteableModuleProtocol>: CompleteableModuleProtocol
where First.Result == Second.Dependencies,
First.Presenter == Second.Presenter {
  
  public typealias Result = Second.Result
  
  public var delegate: ((Second.Result) -> Void)? {
    get {
      return self.second.delegate
    }
    set {
      self.second.delegate = newValue
    }
  }
  
  private var first: First!
  private var second: Second!
  private var presenter: First.Presenter?
  
  private lazy var firstDelegate: (First.Result) -> Void = { result in
    guard
      let presenter = self.presenter
      else { fatalError("First module is ending with no way to present the second!") }
    
    self.second.start(with: presenter, and: result)
  }
  
  public init(first: First, second: Second) {
    self.first = first
    self.second = second
  }
  
  public func start(with presenter: First.Presenter, and dependencies: First.Dependencies) {
    self.presenter = presenter
    self.first.delegate = self.firstDelegate
    self.first.start(with: presenter, and: dependencies)
  }
}

infix operator ==>>

public func ==>><A, B>(left: A, right: B) -> Flow<A, B>
  where A: CompleteableModuleProtocol, B: CompleteableModuleProtocol {
  return Flow(first: left, second: right)
}
