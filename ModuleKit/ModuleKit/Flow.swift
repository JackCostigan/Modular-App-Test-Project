//
//  Flow.swift
//  ModuleKit
//
//  Created by admin on 27/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

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
    // TODO at this point we should probably deallocate `self.first` otherwise it will live
    // as long as the flow does.
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

public extension CompleteableModuleProtocol {
  func routesTo<NextModule>(_ next: NextModule) -> Flow<Self, NextModule>
    where NextModule: CompleteableModuleProtocol, Self.Presenter == NextModule.Presenter {
      return Flow(first: self, second: next)
  }
}

// I like the idea of using a custom operator to string modules together
// but unfortunately it doesn't seem to export properly
// I think its because I can't make the next statement public?
infix operator ==>>

public func ==>><A, B>(left: A, right: B) -> Flow<A, B>
  where A: CompleteableModuleProtocol, B: CompleteableModuleProtocol {
    return Flow(first: left, second: right)
}
