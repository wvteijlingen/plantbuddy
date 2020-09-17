//
//  BankConnector.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import Combine

enum PlantsRepositoryError: Error, Equatable {}

protocol PlantsRepositoryProtocol {
    /// Fetches plants from the server.
    func plants() -> AnyPublisher<[Plant], PlantsRepositoryError>
}

class PlantsRepository: PlantsRepositoryProtocol {
    private let mockedPlants: [Plant] = [
        Plant(id: UUID(), name: "Monstera", type: .indoors),
        Plant(id: UUID(), name: "Philodendron", type: .indoors),
        Plant(id: UUID(), name: "Spider Plant", type: .indoors),
        Plant(id: UUID(), name: "Daffodils", type: .outdoors),
        Plant(id: UUID(), name: "Caladium", type: .outdoors)
    ]

    func plants() -> AnyPublisher<[Plant], PlantsRepositoryError> {
        // Fake network response after 1 second.
        Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success(self.mockedPlants))
            }
        }
        .eraseToAnyPublisher()
    }
}
