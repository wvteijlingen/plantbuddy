//
//  Reducer.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import ComposableArchitecture

let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    print("Handling action: \(action)")

    switch action {
    case .insertPlant(let plant):
        state.plants = [plant] + state.plants
        return .none

    case .deletePlant(let plantID):
        state.plants = state.plants.filter { $0.id != plantID }
        state.selectedPlantID = nil
        return .none

    case .setPlantsFilter(let filter):
        state.selectedPlantsFilter = filter
        return .none

    case .navigateToPlant(let plantID):
        state.selectedPlantID = plantID
        return .none

    case .fetchPlants:
        state.plantsFetchInFlight = true
        return environment.plantsRepository.plants()
            .catchToEffect()
            .map(AppAction.fetchPlantsResponse)
            // Setting `cancelInFlight` to true makes Swift Composable Architecture automatically
            // cancel any currently in flight "fetchPlants" effects.
            .cancellable(id: "fetchPlants", cancelInFlight: true)

    case .cancelFetchPlants:
        state.plantsFetchInFlight = false
        return .cancel(id: "fetchPlants")

    /// Handle a success response when fetching plants.
    case let .fetchPlantsResponse(.success(plants)):
        state.plantsFetchInFlight = false
        state.plantsFetchError = nil
        state.plants = plants
        return .none

    /// Handle an error when fetching plants.
    case let .fetchPlantsResponse(.failure(error)):
        state.plantsFetchInFlight = false
        state.plantsFetchError = "Something went wrong fetching the plants."
        return .none

    /// Save the current state to user defaults.
    case .saveState:
        if let encoded = try? JSONEncoder().encode(state) {
            UserDefaults.standard.set(encoded, forKey: "state")
        }

        return .none

    /// Load the current state from user defaults.
    case .loadState:
        if let savedState = UserDefaults.standard.object(forKey: "state") as? Data {
            if let decoded = try? JSONDecoder().decode(AppState.self, from: savedState) {
                state = decoded
            }
        }
        return .none
    }
}
