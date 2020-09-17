//
//  AppEnvironment.swift
//  Plantbuddy
//
//  Created by Ward van Teijlingen on 12/07/2020.
//  Copyright © 2020 Ward van Teijlingen. All rights reserved.
//

import Foundation
import Combine
import ComposableArchitecture

struct AppEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
  var plantsRepository: PlantsRepositoryProtocol
}
