//
//  TripPlannerViewModel.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 23/8/22.
//

import SwiftUI

@MainActor class TripPlannerViewModel: ObservableObject {
    @Published private(set) var trips: [Connection] = []
    @Published private(set) var cheapTrip: [CheapTrip] = []
    
    @Published var isLoading: Bool = true
    @Published var onError: Bool = false
    @Published var uniqueCityNames: [String] = []
    
    func loadTrips() async {
        Task {
            self.isLoading = true
            do {
                let trips = try await TripFetcher.fetchTrips()
                self.populateTrips(trips)
                self.uniqueCityNames = getNamesOfCitys(self.trips)
                self.isLoading = false
            } catch {
                print("Request failed with error: \(error)")
                self.isLoading = false
                self.onError = true
            }
        }
    }
    
    func loadTripsTest() {
        if let path = Bundle.main.path(forResource: "Trips", ofType: "json") {
            let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let tripsTest = try! JSONDecoder().decode(TripResponse.self, from: data).connections ?? []
            self.populateTrips(tripsTest)
            self.uniqueCityNames = getNamesOfCitys(self.trips)
            self.isLoading = false
        }
    }

    init() {
        trips = []
    }

    init(mockData: Bool) {
        if mockData {
            loadTripsTest()
        }
    }
}

// MARK: - Utils
extension TripPlannerViewModel {
    func cheapestTripConnection(from: String, to: String) {
        if (!(uniqueCityNames.contains(from) &&
              uniqueCityNames.contains(to))) {
            return
        }
        var nodes: [CityNode] = []
        for city in uniqueCityNames {
            nodes.append(CityNode(name: city))
        }

        for trip in trips {
            let nodeFrom = nodes.first(where: {$0.name == trip.from})!
            let nodeTo = nodes.first(where: {$0.name == trip.to})!

            nodeFrom.coordinatesLatLong = trip.coordinates?.from
            nodeTo.coordinatesLatLong = trip.coordinates?.to
            nodeFrom.connections.append(NodeConnection(to: nodeTo, price: trip.price))
        }

        let fromNode = nodes.first(where: {$0.name == from})!
        let toNode = nodes.first(where: {$0.name == to})!

        let path = shortestPath(from: fromNode, to: toNode)
        self.cheapTrip = [CheapTrip(nodesTrip: path?.array.reversed().compactMap({ $0 as? CityNode}) ?? [], price: path?.cumulativePrice ?? 0)]
    }

    func populateTrips(_ trips: [Connection]) {
        for trip in trips {
            self.trips.append(trip)
        }
    }

    func getNamesOfCitys(_ trips: [Connection]) -> [String] {
        let citysNames = trips.map { $0.from } + trips.map { $0.to }
        let uniquecitysNames = uniqueElementsFrom(citysNames)
        return uniquecitysNames
    }

    func uniqueElementsFrom(_ array: [String]) -> [String] {
        var set = Set<String>()
        let result = array.filter {
            guard !set.contains($0) else {
                return false
            }
            set.insert($0)
            return true
        }
        return result
    }
}
