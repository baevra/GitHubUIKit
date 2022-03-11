//
//  RepositoryCellViewModel.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 11.03.2022.
//

import Foundation
import IGListKit

public final class RepositoryCellViewModel: Identifiable, Equatable, ListDiffable {
  public let id: Int
  public let name: String
  public let description: String?
  public let starsCount: Int
  public let forksCount: Int

  public init(
    id: Int,
    name: String,
    description: String?,
    starsCount: Int,
    forksCount: Int
  ) {
    self.id = id
    self.name = name
    self.description = description
    self.starsCount = starsCount
    self.forksCount = forksCount
  }

  public func diffIdentifier() -> NSObjectProtocol {
    return id as NSObjectProtocol
  }

  public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard self !== object else { return true }
    guard let object = object as? RepositoryCellViewModel else { return false }
    return self == object
  }

  public static func == (lhs: RepositoryCellViewModel, rhs: RepositoryCellViewModel) -> Bool {
    return lhs.id == rhs.id
    && lhs.name == rhs.name
    && lhs.description == rhs.description
    && lhs.starsCount == rhs.starsCount
    && lhs.forksCount == rhs.forksCount
  }
}
