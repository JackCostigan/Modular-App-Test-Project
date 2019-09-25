//
//  Presenter.swift
//  FlowController
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

public protocol PresenterProtocol {
  associatedtype Presentable
  func present(_ presentable: Presentable)
}
