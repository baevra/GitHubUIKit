//
//  BaseState.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import Foundation

enum BaseState<Success, Failure>: Equatable where Success: Equatable, Failure: Error, Failure: Equatable {
  case idle
  case loading
  case success(Success)
  case failure(Failure)

  var isLoading: Bool {
    if case .loading = self {
      return true
    }

    return false
  }

  var success: Success? {
    guard case let .success(success) = self else {
      return nil
    }
    return success
  }

  var failure: Failure? {
    guard case let .failure(failure) = self else {
      return nil
    }

    return failure
  }

  var result: Result<Success, Failure>? {
    if let success = success {
      return .success(success)
    }
    if let failure = failure {
      return .failure(failure)
    }
    return nil
  }
}

enum BaseActionState: Equatable {
  case idle
  case loading
  case complete

  var isLoading: Bool {
    if case .loading = self {
      return true
    }
    return false
  }

  var isComplete: Bool {
    if case .complete = self {
      return true
    }
    return false
  }
}
