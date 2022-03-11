//
//  GetRepositoriesQueryDefault.swift
//  AltaiCoffeeUIKit
//
//  Created by Roman Baev on 05.03.2022.
//

import Foundation
import RxSwift

public class GetRepositoriesQueryDefault: GetRepositoriesQuery {
  public func execute() -> Observable<[Repository]> {
    var components = URLComponents(string: "https://api.github.com/search/repositories")!
    components.queryItems = [
      .init(name: "q", value: "swift"),
      .init(name: "per_page", value: "10")
    ]

    let request = URLRequest(url: components.url!)

    return URLSession.shared.rx.response(request: request)
      .map(\.data)
      .map(Mapper.mapData)
      .map(Mapper.mapResponse)
  }
}

extension GetRepositoriesQueryDefault {
  struct Response: Decodable {
    let items: [Repository]

    struct Repository: Decodable {
      let id: Int
      let name: String
      let description: String?
      let stargazers_count: Int
      let forks_count: Int
    }
  }
}

extension GetRepositoriesQueryDefault {
  enum Mapper {
    static func mapData(_ data: Data) throws -> Response {
      let decoder = JSONDecoder()
      let repositories = try decoder.decode(Response.self, from: data)
      return repositories
    }
    static func mapResponse(_ response: Response) -> [Repository] {
      return response.items
        .map {
          Repository(
            id: $0.id,
            name: $0.name,
            description: $0.description,
            starsCount: $0.stargazers_count,
            forksCount: $0.forks_count
          )
        }
    }
  }
}
