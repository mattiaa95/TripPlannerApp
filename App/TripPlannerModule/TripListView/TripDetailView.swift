//
//  TripDetailView.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 23/8/22.
//

import SwiftUI
import MapKit

struct TripDetailView: View {
    let trip: CheapTrip
    
    var body: some View {
        VStack {
            Text("\(trip.getLabelNodesTrips())")
            Spacer()
            Text("Price: \(trip.price)")
            Divider()
            MapView(trip: trip)
                .ignoresSafeArea(edges: .top)
        }
    }
}
