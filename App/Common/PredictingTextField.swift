//
//  PredictingTextField.swift
//  Trip Planner (iOS)
//
//  Created by Mattia La Spina on 23/8/22.
//

import SwiftUI

struct PredictingTextField: View {

    @Binding var predictableValues: [String]
    @Binding var predictedValues: [String]
    @Binding var textFieldInput: String
    @State var textFieldTitle: String
    @State var predictionInterval: Double?
    @State private var isBeingEdited: Bool = false

    init(predictableValues: Binding<[String]>,
         predictedValues: Binding<[String]>,
         textFieldInput: Binding<String>,
         textFieldTitle: String,
         predictionInterval: Double? = 0.1) {
        self._predictableValues = predictableValues
        self._predictedValues = predictedValues
        self._textFieldInput = textFieldInput
        self.textFieldTitle = textFieldTitle
        self.predictionInterval = predictionInterval
    }

    var body: some View {
        HStack {
            Text(self.textFieldTitle)
            Spacer()
            TextField(self.textFieldTitle,
                      text: self.$textFieldInput,
                      onEditingChanged: { editing in self.realTimePrediction(status: editing)},
                      onCommit: { self.makePrediction()})
            .padding(.all)
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }

    /// Schedules prediction based on interval and only a if input is being made
    private func realTimePrediction(status: Bool) {
        self.isBeingEdited = status
        if status == true {
            Timer.scheduledTimer(withTimeInterval: self.predictionInterval ?? 0.1, repeats: true) { timer in
                self.makePrediction()

                if self.isBeingEdited == false {
                    timer.invalidate()
                }
            }
        }
    }

    /// Capitalizes the first letter of a String
    private func capitalizeFirstLetter(smallString: String) -> String {
        return smallString.prefix(1).capitalized + smallString.dropFirst()
    }

    /// Makes prediciton based on current input
    private func makePrediction() {
        self.predictedValues = []
        if !self.textFieldInput.isEmpty {
            for value in self.predictableValues {
                if self.textFieldInput.split(separator: " ").count > 1 {
                    self.makeMultiPrediction(value: value)
                } else {
                    if value.contains(self.textFieldInput) ||
                        value.contains(self.capitalizeFirstLetter(smallString: self.textFieldInput)) {
                        if !self.predictedValues.contains(String(value)) {
                            self.predictedValues.append(String(value))
                        }
                    }
                }
            }
        }
    }

    /// Makes predictions if the input String is splittable
    private func makeMultiPrediction(value: String) {
        for subString in self.textFieldInput.split(separator: " ") {
            if value.contains(String(subString)) ||
                value.contains(self.capitalizeFirstLetter(smallString: String(subString))) {
                if !self.predictedValues.contains(value) {
                    self.predictedValues.append(value)
                }
            }
        }
    }
}
