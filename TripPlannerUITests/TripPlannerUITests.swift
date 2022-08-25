//
//  TripPlannerUITests.swift
//  TripPlannerUITests
//
//  Created by Mattia La Spina on 24/8/22.
//

import XCTest

class TripPlannerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testUITestTrip() {
        let app = XCUIApplication()
        app.launchArguments.append("TEST")
        app.launch()
        
        let tablesQuery = app.tables
        let departureTextField = tablesQuery.textFields["Departure City: "]
        departureTextField.tap()
        departureTextField.typeText("Los Angeles")
        
        let destinationTextField = tablesQuery.textFields["Destination City: "]
        destinationTextField.tap()
        destinationTextField.typeText("Porto")

        tablesQuery.cells["Search"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        
        tablesQuery.cells["Los Angeles -> Tokyo -> London -> Porto, Price 400"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
        sleep(2)
    }
    
}
