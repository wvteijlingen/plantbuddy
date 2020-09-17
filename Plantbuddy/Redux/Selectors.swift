//
//  Selectors.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import ComposableArchitecture

enum Selector {
    static func plants(ofType type: PlantType?, store: AppStore) -> [Plant] {
        let store = ViewStore(store)
        guard let type = type else { return store.plants }
        return store.plants.filter { $0.type == type }
    }
}
