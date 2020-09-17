//
//  Store.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

/// Holds all the state for the entire app.
struct AppState: Equatable, Codable {
    var plants: [Plant]
    var selectedPlantsFilter: PlantType?
    var selectedPlantID: Plant.ID?
    var plantsFetchInFlight: Bool
    var plantsFetchError: String?
}
