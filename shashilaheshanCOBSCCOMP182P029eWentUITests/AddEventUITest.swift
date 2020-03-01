//
//  AddEventUITest.swift
//  shashilaheshanCOBSCCOMP182P029eWentUITests
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import XCTest

class AddEventUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddEventUITest() {
        
        let app = XCUIApplication()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.staticTexts["You can upload ay nibm events"].swipeLeft()
        scrollViewsQuery.children(matching: .other).element.children(matching: .other).element/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        elementsQuery.buttons["Let's Login"].tap()
        elementsQuery.textFields["Username"].tap()
        
        let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
        passwordSecureTextField.tap()
        elementsQuery.buttons["Login"].tap()
        passwordSecureTextField.tap()
        app.buttons["+"].tap()
        elementsQuery.textFields["Event Name"].tap()
        scrollViewsQuery.otherElements.containing(.textField, identifier:"Event Name").element.swipeDown()
        elementsQuery.buttons["+"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Current Location"]/*[[".cells.staticTexts[\"Current Location\"]",".staticTexts[\"Current Location\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.textFields["Description"].tap()
        elementsQuery.buttons["Select"].tap()
        app.alerts["Select source"].buttons["GALLERY"].tap()
        //After this simulator cannot trigger Galary processes
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
