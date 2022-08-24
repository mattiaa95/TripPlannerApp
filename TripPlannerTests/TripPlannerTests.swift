//
//  TripPlannerTests.swift
//  TripPlannerTests
//
//  Created by Mattia La Spina on 24/8/22.
//

import XCTest
@testable import Trip_Planner

class TripPlannerViewModelTests: XCTestCase {
    
    @MainActor func testInitialization() {
        let tripPlannerViewModel = TripPlannerViewModel(mockData: true)

        XCTAssertNotNil(tripPlannerViewModel)
        XCTAssertFalse(tripPlannerViewModel.isLoading)
        XCTAssertEqual(tripPlannerViewModel.trips.count, 9)
    }
    
    @MainActor func testGetNamesOfCitys() {
        let tripPlannerViewModel = TripPlannerViewModel(mockData: true)
        
        let uniqueCityNames = tripPlannerViewModel.getNamesOfCitys(tripPlannerViewModel.trips)
        XCTAssertNotNil(uniqueCityNames)
        XCTAssertEqual(uniqueCityNames, ["London", "Tokyo", "Sydney", "Cape Town", "New York", "Los Angeles", "Porto"])
    }
    
    @MainActor func testUniqueElementsFrom() {
        let tripPlannerViewModel = TripPlannerViewModel(mockData: true)
        let uniqueArray = tripPlannerViewModel.uniqueElementsFrom(["one", "one", "two", "two", "three", "three"])
        XCTAssertNotNil(uniqueArray)
        XCTAssertEqual(uniqueArray, ["one", "two", "three"])
    }
    
    @MainActor func testCheapestTripConnection() {
        let tripPlannerViewModel = TripPlannerViewModel(mockData: true)
        
        tripPlannerViewModel.cheapestTripConnection(from: "", to: "")
        XCTAssertEqual(tripPlannerViewModel.cheapTrip.count, 0)

        tripPlannerViewModel.cheapestTripConnection(from: "Los Angeles", to: "Porto")
        
        XCTAssertNotNil(tripPlannerViewModel.cheapTrip)
        XCTAssertEqual(tripPlannerViewModel.cheapTrip.first?.price, 400)
        XCTAssertEqual(tripPlannerViewModel.cheapTrip.first?.getLabelNodesTrips(), "Los Angeles -> Tokyo -> London -> Porto")
    }
}

class DijkstraTests: XCTestCase {

    func testDijkstraPath() {
        
        let nodeA = CityNode(name: "A")
        let nodeB = CityNode(name: "B")
        let nodeC = CityNode(name: "C")
        let nodeD = CityNode(name: "D")
        let nodeE = CityNode(name: "E")

        nodeA.connections.append(NodeConnection(to: nodeB, price: 1))
        nodeB.connections.append(NodeConnection(to: nodeC, price: 3))
        nodeC.connections.append(NodeConnection(to: nodeD, price: 1))
        nodeB.connections.append(NodeConnection(to: nodeE, price: 1))
        nodeE.connections.append(NodeConnection(to: nodeC, price: 1))

        let path = shortestPath(from: nodeA, to: nodeD)
        let succession: [String] = (path?.array.reversed().compactMap({ $0 as? CityNode}).map({$0.name}))!

        XCTAssertEqual(succession, ["A", "B", "E", "C", "D"])
        XCTAssertEqual(path?.cumulativePrice, 4)
        //nil
        XCTAssertNil(shortestPath(from: nodeE, to: nodeD))

    }
}

class TripFetcherTests: XCTestCase {    
    func testFetchTrips() async {
        do {
            let trips = try await TripFetcher.fetchTrips()
            XCTAssertEqual(trips.count, 9)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    func testFetchTripsFailUrl() async {
        
        do {
            let trips = try await TripFetcher.fetchTrips()
            XCTAssertEqual(trips.count, 9)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}

