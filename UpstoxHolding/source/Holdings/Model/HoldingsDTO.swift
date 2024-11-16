//
//  HoldingsDTO.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import Foundation

struct DataDTO: Decodable {
    let data: HoldingsDTO
    
    func toDomain() -> Holdings {
        data.toDomain()
    }
}
// MARK: - HoldingsDTO
struct HoldingsDTO: Decodable {
    let userHolding: [UserHoldingDTO]

    func toDomain() -> Holdings {
        let userholdings = userHolding.map { $0.toDomain() }
        return .init(userHoldings: userholdings.sorted { $0.symbol.compare($1.symbol) == .orderedAscending })
    }
}

// MARK: - UserHoldingDTO
struct UserHoldingDTO: Decodable {
    let symbol: String
    let quantity: Int
    let ltp: Double
    let avgPrice: Double
    let close: Double
    
    func toDomain() -> UserHolding {
        return .init(
            symbol: symbol,
            quantity: quantity,
            ltp: ltp,
            avgPrice: avgPrice,
            close: close
        )
    }
}

protocol HoldingsRepository {
    init(networkManager: NetworkManagerProtocol)
    func getHoldings() async throws -> Holdings
}

struct HoldingsRepositoryImpl: HoldingsRepository {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getHoldings() async throws -> Holdings {
        let endPoint = HoldingsEndpoint.holdings
        let response = try await networkManager.execute(endpoint: endPoint,
                                                        responseModel: DataDTO.self)
        return response.toDomain()
    }
}

protocol GetHoldingUseCase {
    init(repository: HoldingsRepository)
    func execute() async throws -> Holdings
}

struct GetHoldingUseCaseImpl: GetHoldingUseCase {
    private let repository: HoldingsRepository

    init(repository: HoldingsRepository) {
        self.repository = repository
    }

    func execute() async throws -> Holdings {
        try await repository.getHoldings()
    }
}
