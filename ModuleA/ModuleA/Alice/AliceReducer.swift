//
//  AliceReducer.swift
//  ModuleA
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ReSwift

extension Alice {
  static func reducer(action: ReSwift.Action, state: State?) -> State {
    guard
      var state = state,
      let action = action as? Alice.Action
    else { return Alice.State.default }
    
    switch action {
    case .plusButtonPushed:
      state.value += 1
    case .minusButtonPushed:
      state.value -= 1
    case .doneButtonPushed:
      break
    }
    return state
  }
}
