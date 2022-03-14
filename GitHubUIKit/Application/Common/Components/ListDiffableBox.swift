//
//  ListDiffableBox.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation
import IGListKit

public final class ListDiffableBox<T>: ListDiffable where T: Identifiable & Equatable {
  let value: T

  public init(value: T) {
    self.value = value
  }

  public func diffIdentifier() -> NSObjectProtocol {
    return value.id as! NSObjectProtocol
  }

  public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let container = object as? ListDiffableBox<T> else { return false }
    return self.value == container.value
  }
}
