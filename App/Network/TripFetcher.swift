//
//  TripFetcher.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 23/8/22.
//

import Foundation

struct TripFetcher {
    enum TripFetcherError: Error {
        case invalidURL
    }
    static func fetchTrips() async throws -> [Connection] {
        guard let url = URL(string: NetworkConstants.URLBASE) else {
            throw TripFetcherError.invalidURL
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let tripFetcherResult = try JSONDecoder().decode(TripResponse.self, from: data).connections ?? []
        return tripFetcherResult
    }

}
