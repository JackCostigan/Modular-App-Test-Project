//
//  AliceMiddleware.swift
//  ModuleA
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ReSwift

extension Alice {
  class DelegateHandler {
    weak var delegate: ModuleADelegate? = nil
    
    lazy var middleware: Middleware<Alice.State> = { dispatch, getState in
      return { next in
        return { action in
          guard
            let aliceAction = action as? Alice.Action,
            let value = getState()?.value
            else { return next(action) }
          switch aliceAction {
          case .doneButtonPushed:
            self.delegate?.numberReturned(value)
          default:
            break
          }
          return next(action)
        }
      }
    }
  }
}
