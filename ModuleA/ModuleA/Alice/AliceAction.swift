//
//  AliceAction.swift
//  ModuleA
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ReSwift

extension Alice {
  enum Action: String, ReSwift.Action {
    case plusButtonPushed
    case minusButtonPushed
    case doneButtonPushed
  }
}
