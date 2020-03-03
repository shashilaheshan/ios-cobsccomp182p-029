//
//  ForgotPasswordUITest.swift
//  shashilaheshanCOBSCCOMP182P029eWentUITests
//
//  Created by Shashila Heshan on 3/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import XCTest

class ForgotPasswordUITest: XCTestCase {

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

    func testForgotPasswordUI() {
        
        let app = XCUIApplication()
        let elementsQuery = app.scrollViews.otherElements
        let youCanUploadAyNibmEventsStaticText = elementsQuery.staticTexts["You can upload ay nibm events"]
        youCanUploadAyNibmEventsStaticText.swipeLeft()
        youCanUploadAyNibmEventsStaticText.swipeLeft()
        youCanUploadAyNibmEventsStaticText.swipeLeft()
        elementsQuery.buttons["Let's Login"].tap()
        elementsQuery.buttons["Forgot your password?"].tap()
        
        let emailAddressTextField = elementsQuery.textFields["Email address"]
        emailAddressTextField.tap()
        app.typeText("ebayshashila@gmail.com")
        elementsQuery.buttons["Reset Password"].tap()
        app.otherElements.containing(.alert, identifier:"Email sent..").children(matching: .other).element(boundBy: 0).tap()
        app.alerts["Email sent.."].buttons["OK"].tap()
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
