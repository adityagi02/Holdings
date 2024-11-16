//
//  MockNetworkManager.swift
//  UpstoxHolding
//
//  Created by Pritesh Singhvi on 13/11/24.
//

import Foundation
@testable import UpstoxHolding

final class MockNetworkManager: NetworkManagerProtocol {
    private let fileName: String
    init(fileName: String) {
        self.fileName = fileName
    }
    
    var url: URL {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        return thisDirectory.appendingPathComponent("Files/\(self.fileName).json")
    }
    
    private func data(from file: String) throws -> Data {
        return try Data(contentsOf: url)
    }

    func execute<T: Decodable>(endpoint: any UpstoxHolding.Endpoint,
                    responseModel: T.Type) async throws -> T {
        do {
            let data = try data(from: fileName)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            return parsedData
        } catch {
            throw error
        }
    }
    
}
