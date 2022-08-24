# TripPlannerApp
![icon](https://raw.githubusercontent.com/mattiaa95/TripPlannerApp/main/App/Resources/Assets.xcassets/AppIcon.appiconset/180.png)
   
Trip Planner in SwiftUI with MVVM architecture, show the cheapest flight route on a​ map, with Dijkstra's algorithm for finding the shortest paths between nodes in a graph.    
no Pods, no Swift Packages.

Articles and documentation used:
- https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
- https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html
- https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm


## Getting Started

Instructions to start working on TripPlannerApp

### Requirements 🚧

- Xcode 13
- Swift 5

### Setup ⚙

1. Fork this repository or clone the repository
2. Open Trip Planner.xcodeproj with Xcode
3. Done! Enjoy

### Project Tree 📁

```
.
├── App
│   ├── Common
│   │   └── Dijkstra
│   ├── Network
│   │   └── Responses
│   ├── Resources
│   │   └── Assets.xcassets
│   │       ├── AccentColor.colorset
│   │       └── AppIcon.appiconset
│   └── TripPlannerModule
│       ├── Model
│       └── TripListView
├── TripPlannerTests
└── TripPlannerUITests
```

### Dijkstra's algorithm

Dijkstra's algorithm to find the shortest path between a and b. It picks the unvisited vertex with the lowest distance, calculates the distance through it to each unvisited neighbor, and updates the neighbor's distance if smaller. Mark visited (set to red) when done with neighbors.

![Dijkstra_Animation](https://upload.wikimedia.org/wikipedia/commons/5/57/Dijkstra_Animation.gif)

Do not use A* for this reason:

Compared to Dijkstra's algorithm, the A* algorithm only finds the shortest path from a specific source to a specific target, and not the tree of shortest paths from a specific source to all possible targets. This is a necessary trade-off for using a goal-directed heuristic. In the case of Dijkstra's algorithm, since the entire shortest path tree is generated, each node is a goal, and there can be no goal-directed heuristic.

- https://en.wikipedia.org/wiki/A*_search_algorithm

### Project Screenshots 📱
<img src="https://user-images.githubusercontent.com/11006805/186458277-1fbfabaf-1eea-49d9-b20e-a1a88dd1c832.png" width="150">  <img src="https://user-images.githubusercontent.com/11006805/186458293-2fc3ca70-fb6f-4232-9c25-301c8b01e8a2.png" width="150"> <img src="https://user-images.githubusercontent.com/11006805/186458305-aa994ef6-caae-4943-9ae8-8d27f60d26a1.png" width="150">

<img src="https://user-images.githubusercontent.com/11006805/186458289-7e412cb0-0703-426b-bfbc-75f6a6c43aa5.png" width="150"> <img src="https://user-images.githubusercontent.com/11006805/186458296-984b4259-c4fa-4d69-a81b-18c1fe9baaf5.png" width="150"> <img src="https://user-images.githubusercontent.com/11006805/186458299-4bcc5b7e-4f0a-4d65-a242-7890317c041c.png" width="150">

![CoverageXcode](https://user-images.githubusercontent.com/11006805/186459343-d81f55c5-72c9-4c24-aa98-df348e8b3bb3.png)
