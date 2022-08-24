//
//  TripResponse.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 23/8/22.
//
//   let tripResponse = try? newJSONDecoder().decode(TripResponse.self, from: jsonData)

import Foundation

// MARK: - TripResponse
struct TripResponse: Codable {
    let connections: [Connection]?
}

// MARK: - Connection
struct Connection: Codable {
    let from, to: String
    let coordinates: Coordinates?
    var price: Int
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let from, to: CoordinatesLatLong?
}

// MARK: - From
struct CoordinatesLatLong: Codable {
    let lat, long: Double?
}
