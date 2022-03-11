//
//  RepositoryVSQuery.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 11.03.2022.
//

import Foundation

// Repository
protocol UserRepository {
  func getUser(by id: UUID) throws -> User
  func updateUser(_ user: User) throws -> User
  func deleteUser(by id: UUID) throws -> Void
}

// Query
protocol GetUserQuery {
  func execute(by id: UUID) throws -> User
}

protocol UpdateUserQuery {
  func execute(_ user: User) throws -> User
}

protocol DeleteUserQuery {
  func execute(by id: UUID) throws -> User
}
