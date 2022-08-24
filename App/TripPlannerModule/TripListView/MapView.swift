//
//  MapView.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 23/8/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let trip: CheapTrip
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.region = setRegionMap(trip: trip)

        mapView.addOverlay(setLineCoordinates(trip: trip))
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func setLineCoordinates(trip: CheapTrip) -> MKPolyline {
        var lineCoordinates: [CLLocationCoordinate2D] = []
        for trip in trip.nodesTrip {
            lineCoordinates.append(CLLocationCoordinate2D(latitude: trip.coordinatesLatLong?.lat ?? 0,
                                                          longitude: trip.coordinatesLatLong?.long ?? 0))
        }
        return MKPolyline(coordinates: lineCoordinates, count: lineCoordinates.count)
    }

    func setRegionMap(trip: CheapTrip) -> MKCoordinateRegion {
        let lat: Double = trip.nodesTrip.map({$0.coordinatesLatLong?.lat ?? 0}).reduce(0, +)
        let long: Double = trip.nodesTrip.map({$0.coordinatesLatLong?.long ?? 0}).reduce(0, +)
        let center = CLLocationCoordinate2D(latitude: lat/Double(trip.nodesTrip.count),
                                            longitude:long/Double(trip.nodesTrip.count))
        return MKCoordinateRegion( center:center,span: MKCoordinateSpan(latitudeDelta: 120, longitudeDelta: 120))
    }
}

class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView

    init(_ parent: MapView) {
        self.parent = parent
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let routePolyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: routePolyline)
            renderer.strokeColor = UIColor.systemGreen
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer()
    }
}
