//
//  Store.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import ComposableArchitecture

typealias AppStore = Store<AppState, AppAction>

let appStore: AppStore = Store(
    initialState: AppState(
        plants: [],
        plantsFetchInFlight: false,
        plantsFetchError: nil
    ),
    reducer: appReducer,
    environment: AppEnvironment(
        mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
        plantsRepository: PlantsRepository()
    )
)
