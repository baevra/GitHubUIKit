//
//  User.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import Foundation

public struct User: Identifiable, Equatable {
  public let id: Int
  public let login: String
  public let avatarURL: URL?
}
