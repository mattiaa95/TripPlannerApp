//
//  TripNode.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 24/8/22.
//

import Foundation

class CityNode: Node {
  
    let name: String
    var coordinatesLatLong: CoordinatesLatLong?
    
  init(name: String) {
    self.name = name
    super.init()
  }
}
