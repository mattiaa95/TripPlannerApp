//
//  NodeConnection.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 24/8/22.
//

import Foundation

class NodeConnection {
  public let to: Node
  public let price: Int

  public init(to node: Node, price: Int) {
    self.to = node
    self.price = price
  }
}
