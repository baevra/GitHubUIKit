//
//  Identifiable.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 14.03.2022.
//

import Foundation

public protocol Identifiable {
  associatedtype ID : Hashable

  var id: Self.ID { get }
}
