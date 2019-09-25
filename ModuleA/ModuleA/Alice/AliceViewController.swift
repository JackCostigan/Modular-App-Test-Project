//
//  AliceViewController.swift
//  ModuleA
//
//  Created by admin on 24/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation
import ReSwift

class AliceViewController: UIViewController {
  
  static var identifier: String = "Alice"
  
  var store: Store<Alice.State>!
  
  @IBOutlet weak var number: UILabel!
  @IBOutlet weak var text: UILabel!
  
  @IBAction func plusbuttonPushed(_ sender: Any) {
    store.dispatch(Alice.Action.plusButtonPushed)
  }
  
  @IBAction func minusButtonPushed() {
    store.dispatch(Alice.Action.minusButtonPushed)
  }
  
  @IBAction func doneButtonPushed() {
    store.dispatch(Alice.Action.doneButtonPushed)
  }
  override func viewDidLoad() {
    store.subscribe(self)
  }
}

extension AliceViewController: StoreSubscriber {
  typealias StoreSubscriberStateType = Alice.State
  
  func newState(state: Alice.State) {
    number.text = "\(state.value)"
    text.text = state.text
  }
}
