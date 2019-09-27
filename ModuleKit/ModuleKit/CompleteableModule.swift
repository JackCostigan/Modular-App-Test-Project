//
//  CompleteableModule.swift
//  ModuleKit
//
//  Created by admin on 27/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

public protocol CompleteableModuleProtocol: ModuleProtocol where Delegate == (Result) -> Void {
  associatedtype Result
}
