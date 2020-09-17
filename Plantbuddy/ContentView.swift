//
//  ContentView.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 19/06/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: AppStore

    var body: some View {
        NavigationView {
            PlantsList(store: store)
                .navigationBarTitle("Plants")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: appStore)
    }
}
