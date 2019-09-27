//
//  ModuleTransformer.swift
//  ModuleKit
//
//  Created by admin on 27/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

public class ModuleTransformer<ModuleType, InputType>: CompleteableModuleProtocol
where ModuleType: CompleteableModuleProtocol {
  public typealias Result = ModuleType.Result
  public typealias Delegate = ModuleType.Delegate
  public typealias Presenter = ModuleType.Presenter
  public typealias Dependencies = InputType
  
  private var module: ModuleType
  private let transformer: (InputType) -> ModuleType.Dependencies
  
  public var delegate: ModuleType.Delegate? {
    set {
      module.delegate = newValue
    }
    get {
      return module.delegate
    }
  }
  
  public init(module: ModuleType, transformer: @escaping ((InputType) -> ModuleType.Dependencies)) {
    self.module = module
    self.transformer = transformer
  }
  
  public func start(with presenter: ModuleType.Presenter, and input: InputType) {
    let dependencies = transformer(input)
    module.start(with: presenter, and: dependencies)
  }
}

public extension CompleteableModuleProtocol {
  func inputTransformer<InputType>(_ transformer: @escaping ((InputType) -> Dependencies)) -> ModuleTransformer<Self, InputType> {
    return ModuleTransformer(module: self, transformer: transformer)
  }
}
