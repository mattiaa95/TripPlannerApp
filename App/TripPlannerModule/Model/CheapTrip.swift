//
//  CheapTrip.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 24/8/22.
//

import Foundation

class CheapTrip: Identifiable {
    let id = UUID()
    let nodesTrip: [CityNode]
    let price: Int
    
    func getLabelNodesTrips() -> String {
        let arrayMap: Array = nodesTrip.map(){ $0.name }
        return arrayMap.joined(separator: " -> ")
    }
    
    init(nodesTrip: [CityNode],price: Int) {
        self.nodesTrip = nodesTrip
        self.price = price
    }
}
