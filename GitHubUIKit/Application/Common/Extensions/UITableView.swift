//
//  UITableView.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit

extension UITableView {
  public func register(_ cellClass: AnyClass) {
    register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
  }

  public func dequeueReusableCell<T>(for type: T.Type) -> T {
    return dequeueReusableCell(withIdentifier: String(describing: type)) as! T
  }
}
