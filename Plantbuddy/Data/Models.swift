//
//  Models.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation

struct Plant: Identifiable, Equatable, Codable {
    let id: UUID
    let name: String
    let type: PlantType
}

enum PlantType: String, Codable {
    case indoors = "indoors", outdoors = "outdoors"

    var name: String {
        switch self {
        case .indoors: return "Indoors"
        case .outdoors: return "Outdoors"
        }
    }
}
