//
//  TripPlannerApp.swift
//  Shared
//
//  Created by Mattia La Spina on 23/8/22.
//

import SwiftUI

@main
struct TripPlannerApp: App {
    @ObservedObject var model = TripPlannerViewModel()
    var body: some Scene {
        WindowGroup {
            TripPlannerView(viewModel: self.model)
        }
    }
}
