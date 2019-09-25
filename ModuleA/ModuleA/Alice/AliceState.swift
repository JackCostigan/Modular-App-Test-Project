//
//  AliceState.swift
//  ModuleA
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ReSwift

extension Alice {
  struct State: StateType {
    var value: Int
    let text: String
    
    init(value: Int = 0, text: String = "") {
      self.value = value
      self.text = text
    }
  }
}

extension Alice.State {
  static var `default` = Alice.State()
}
