//
//  PlantDetail.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PlantDetail: View {
    let store: AppStore
    let plant: Plant

    var body: some View {
        WithViewStore(store) { viewStore in
            VStack {
                Text(self.plant.name)
                Text(self.plant.type.name)

                Spacer()

                Button("Delete plant") {
                    viewStore.send(.deletePlant(withID: self.plant.id))
                }

                Spacer()
            }
        }
        .navigationBarTitle(plant.name)
    }
}
