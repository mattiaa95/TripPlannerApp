//
//  TripCellView.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 23/8/22.
//

import SwiftUI

struct TripCellView : View {
    let trip: CheapTrip

    var body: some View {
        HStack(alignment: .center, spacing: 10.0){
            Text("\(trip.getLabelNodesTrips())")
            Spacer()
            Text("Price \(trip.price)")
        }
    }
}
