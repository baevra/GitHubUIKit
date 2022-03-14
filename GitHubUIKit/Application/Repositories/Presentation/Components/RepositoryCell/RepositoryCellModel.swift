//
//  RepositoryCellModel.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 11.03.2022.
//

import Foundation
import IGListKit

public struct RepositoryCellModel: Identifiable, Equatable {
  public let id: Int
  public let name: String
  public let description: String?
  public let starsCount: Int
  public let forksCount: Int
}
