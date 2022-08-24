//
//  TripPlannerView.swift
//  Shared
//
//  Created by Mattia La Spina on 23/8/22.
//

import SwiftUI

struct TripPlannerView: View {
    @ObservedObject var viewModel: TripPlannerViewModel

    @State var departureCity: String = ""
    @State var destinationCity: String = ""
    @State var predictedDepartureCity: [String] = []
    @State var predictedDestinationCity: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                    if viewModel.isLoading {ProgressView().zIndex(1)}
                    TripPlannerFieldsView()
            }.alert(isPresented: $viewModel.onError) {networkAlert()}

        }
    }

    func TripPlannerFieldsView() -> some View {
        return Form {
            PredictingTextField(predictableValues: $viewModel.uniqueCityNames,
                                predictedValues: self.$predictedDepartureCity,
                                textFieldInput: self.$departureCity,
                                textFieldTitle: "Departure City: ")

            HStack {
                ForEach(self.predictedDepartureCity, id: \.self) { suggestion in
                    Text(suggestion).foregroundColor(Color.green).multilineTextAlignment(.center).onTapGesture {
                        departureCity = suggestion
                        viewModel.cheapestTripConnection(from: departureCity, to: destinationCity)
                    }
                }
            }

            PredictingTextField(predictableValues: $viewModel.uniqueCityNames,
                                predictedValues: self.$predictedDestinationCity,
                                textFieldInput: self.$destinationCity,
                                textFieldTitle: "Destination City: ")

            HStack {
                ForEach(self.predictedDestinationCity, id: \.self) { suggestion in
                    Text(suggestion).foregroundColor(Color.green).multilineTextAlignment(.center).onTapGesture {
                        destinationCity = suggestion
                        viewModel.cheapestTripConnection(from: departureCity, to: destinationCity)
                    }
                }
            }

            Button("Search") {
                viewModel.cheapestTripConnection(from: departureCity, to: destinationCity)
            }

            List(viewModel.cheapTrip, id: \.id) { trip in
                        NavigationLink {
                            TripDetailView(trip: trip)
                        } label: {
                            TripCellView(trip: trip)
                        }
            }

        }.task {
            await viewModel.loadTrips()
        }.navigationTitle("Trip Planner")
    }
    //    TODO: Get Message from ViewModel
    func networkAlert() -> Alert {
        return Alert(title: Text("Network Error"),
                     message: Text("Please try again later!"),
                     dismissButton: .default(Text("OK")))
    }
}

struct TripPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        TripPlannerView(viewModel: TripPlannerViewModel.init(mockData: true),
                        departureCity: "Tokio",
                        destinationCity: "London")
    }
}
