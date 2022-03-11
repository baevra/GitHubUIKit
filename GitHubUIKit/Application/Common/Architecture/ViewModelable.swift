//
//  ViewModelable.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import Foundation
import RxSwift

public protocol ViewModelable {
  associatedtype State
  associatedtype Action

  var state: Observable<State> { get }

  func dispatch(_ action: Action)
}
