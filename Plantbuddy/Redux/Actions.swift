//
//  Actions.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import UIKit

/// All the actions that can be performed on the store.
enum AppAction {
    case insertPlant(Plant)
    case deletePlant(withID: Plant.ID)
    case setPlantsFilter(to: PlantType?)

    // Network
    case fetchPlants
    case cancelFetchPlants
    case fetchPlantsResponse(Result<[Plant], PlantsRepositoryError>)

    // Navigation
    case navigateToPlant(withID: Plant.ID?)
}
