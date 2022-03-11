//
//  GetUsersQueryDefault.swift
//  GitHubUIKit
//
//  Created by Roman Baev on 10.03.2022.
//

import Foundation
import RxSwift

public class GetUsersQueryDefault: GetUsersQuery {
  public func execute() -> Observable<[User]> {
    var components = URLComponents(string: "https://api.github.com/search/users")!
    components.queryItems = [
      .init(name: "q", value: "A"),
      .init(name: "per_page", value: "10")
    ]

    let request = URLRequest(url: components.url!)

    return URLSession.shared.rx.response(request: request)
      .map(\.data)
      .map(Mapper.mapData)
      .map(Mapper.mapResponse)
  }
}

extension GetUsersQueryDefault {
  struct Response: Decodable {
    let items: [User]

    struct User: Decodable {
      let id: Int
      let login: String
      let avatar_url: String?
    }
  }
}

extension GetUsersQueryDefault {
  enum Mapper {
    static func mapData(_ data: Data) throws -> Response {
      let decoder = JSONDecoder()
      let repositories = try decoder.decode(Response.self, from: data)
      return repositories
    }
    static func mapResponse(_ response: Response) -> [User] {
      return response.items
        .map {
          User(
            id: $0.id,
            login: $0.login,
            avatarURL: $0.avatar_url.flatMap(URL.init(string:))
          )
        }
    }
  }
}
