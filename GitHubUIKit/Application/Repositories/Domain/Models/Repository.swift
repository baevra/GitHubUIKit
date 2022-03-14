//
//  Repository.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import Foundation

public struct Repository: Identifiable, Equatable {
  public let id: Int
  public let name: String
  public let description: String?
  public let starsCount: Int
  public let forksCount: Int
}
