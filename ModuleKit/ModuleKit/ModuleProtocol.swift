//
//  ModuleProtocol.swift
//  ModuleKit
//
//  Created by admin on 25/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

public protocol ModuleProtocol {
  associatedtype Delegate
  associatedtype Presenter: RouterProtocol
  associatedtype Dependencies
  
  func start(with presenter: Presenter, and dependencies: Dependencies)
  var delegate: Delegate? { get set }
}
