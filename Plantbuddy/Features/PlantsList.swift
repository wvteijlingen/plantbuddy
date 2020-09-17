//
//  PlantsList.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import SwiftUI
import ComposableArchitecture

struct PlantsList: View {
    let store: AppStore

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Picker("", selection: self.filterBinding) {
                    Text("All").tag(Filter.all)
                    Text("Indoors").tag(Filter.indoors)
                    Text("Outdoors").tag(Filter.outdoors)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                if ViewStore(self.store).state.plantsFetchInFlight {
                    HStack {
                        Text("Loading plants...")
                        Button("Cancel") {
                            viewStore.send(.cancelFetchPlants)
                        }
                    }
                }

                List(viewStore.filteredPlants) { plant in
                    NavigationLink(
                        destination: PlantDetail(store: self.store, plant: plant),
                        tag: plant.id,
                        selection: viewStore.binding(
                            get: { $0.selectedPlantID },
                            send: {
                                // Bug in SwiftUI causes the binding setter to be called twice.
                                // Fortunately for this app it doesn't matter.
                                // See: https://forums.swift.org/t/navigation-going-back-sends-action-twice/36674
                                .navigateToPlant(withID: $0)
                            }
                        )
                    ) {
                        VStack(alignment: .leading) {
                            Text(plant.name)
                            Text(plant.type.name)
                                .font(Font.system(.caption))
                        }
                    }
                }
            }
        }
        .navigationBarItems(
            leading:
                HStack {
                    Button(action: {
                        ViewStore(self.store).send(.fetchPlants)
                    }, label: {
                        Image(systemName: "arrow.clockwise")
                    })
                    Button("Save state") { ViewStore(self.store).send(.saveState) }
                    Button("Load state") { ViewStore(self.store).send(.loadState) }
                },
            trailing:
                Button(action: {
                    self.createNewPlant()
                }, label: {
                    Image(systemName: "plus")
                })
        )
    }

    private var filterBinding: Binding<Filter> {
        ViewStore(store).binding(
            get: {
                switch $0.selectedPlantsFilter {
                case nil: return .all
                case .indoors: return .indoors
                case .outdoors: return .outdoors
                }
            },
            send: {
                switch $0 {
                case .all: return AppAction.setPlantsFilter(to: nil)
                case .indoors: return AppAction.setPlantsFilter(to: PlantType.indoors)
                case .outdoors: return AppAction.setPlantsFilter(to: PlantType.outdoors)
                }
            }
        )
    }

    private func createNewPlant() {
        let type = [PlantType.indoors, PlantType.outdoors].randomElement() ?? .indoors
        let plant = Plant(id: UUID(), name: "New Plant", type: type)
        ViewStore(store).send(.insertPlant(plant))
    }
}

private enum Filter {
    case all, indoors, outdoors
}

/// Extension that contains custom getters that retrieve data from the store.
///
/// Sometimes you want to combine multiple pieces of data from the store, for example an array of plants filtered
/// by a certain type.
private extension ViewStore where State == AppState, Action == AppAction {
    var filteredPlants: [Plant] {
        guard let selectedFilter = self.selectedPlantsFilter else { return self.plants }
        return self.plants.filter { $0.type == selectedFilter }
    }
}
