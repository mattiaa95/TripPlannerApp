//
//  Path.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 24/8/22.
//

import Foundation

class Path {
  public let cumulativePrice: Int
  public let node: Node
  public let previousPath: Path?

  init(to node: Node, via connection: NodeConnection? = nil, previousPath path: Path? = nil) {
    if
      let previousPath = path,
      let viaConnection = connection {
      self.cumulativePrice = viaConnection.price + previousPath.cumulativePrice
    } else {
      self.cumulativePrice = 0
    }
    self.node = node
    self.previousPath = path
  }
}

extension Path {
  var array: [Node] {
    var array: [Node] = [self.node]

    var iterativePath = self
    while let path = iterativePath.previousPath {
      array.append(path.node)
      iterativePath = path
    }
    return array
  }
}

func shortestPath(from: Node, to: Node) -> Path? {
  var frontier: [Path] = [] {
    didSet { frontier.sort { return $0.cumulativePrice < $1.cumulativePrice } }
  }
  frontier.append(Path(to: from))
  while !frontier.isEmpty {
    let cheapestPathInFrontier = frontier.removeFirst()
    guard !cheapestPathInFrontier.node.visited else { continue }
    if cheapestPathInFrontier.node === to {
      return cheapestPathInFrontier
    }
    cheapestPathInFrontier.node.visited = true
    for connection in cheapestPathInFrontier.node.connections where !connection.to.visited {
      frontier.append(Path(to: connection.to, via: connection, previousPath: cheapestPathInFrontier))
    }
  }
  return nil
}
