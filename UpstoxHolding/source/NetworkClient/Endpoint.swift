//
//  Endpoint.swift
//  UpstoxHolding
//
//  Created by Pritesh Singhvi on 12/11/24.
//

import Foundation

protocol Endpoint {
  var url: URL? { get }
  var method: HTTPMethod { get }
  var headers: [String: String] { get }
  var body: Data? { get }
}

enum HTTPMethod: String {
  case get, post, put, delete, patch
}

enum HoldingsEndpoint: Endpoint {
    private struct Constants {
        static let holdingsUrl: String = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"
    }

    case holdings

    var url: URL? {
        switch self {
        case .holdings:
            return URL(string: Constants.holdingsUrl)
        }
    }

    var method: HTTPMethod {
        switch self {
        case .holdings:
            return .get
        }
    }

    var headers: [String : String] {
        switch self {
        case .holdings:
            return [:]
        }
    }

    var body: Data? {
        switch self {
        case .holdings:
            return nil
        }
    }

}

enum NetworkError: Error {
    case statusCodeError(statusCode: Int)
    case decodingError
    case urlError
    case otherError(error: Error?)
}

protocol NetworkManagerProtocol {
    func execute<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
}

final class NetworkManagerImpl: NetworkManagerProtocol {
    static let shared: NetworkManagerProtocol = NetworkManagerImpl()
    private let decoder = JSONDecoder()
    private init() { }

    func execute<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T {
        guard let url = endpoint.url else {
            throw NetworkError.urlError
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue

        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.statusCodeError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }

        return try decoder.decode(T.self, from: data)
    }
}
