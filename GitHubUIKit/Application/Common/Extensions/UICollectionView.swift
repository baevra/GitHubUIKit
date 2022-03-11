//
//  UICollectionView.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import UIKit

extension UICollectionView {
  func register(_ cellClass: AnyClass) {
    register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
  }

  func register(_ cellClass: AnyClass, forSupplementaryViewOfKind kind: String) {
    register(cellClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: cellClass))
  }

  func dequeueReusableCell<T>(for type: T.Type, for indexPath: IndexPath) -> T {
    return dequeueReusableCell(withReuseIdentifier: String(describing: type), for: indexPath) as! T
  }

  func dequeueReusableSupplementaryView<T>(
    for type: T.Type,
    ofKind kind: String,
    for indexPath: IndexPath) -> T? {
      return dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: String(describing: type),
        for: indexPath
      ) as? T
  }
}
