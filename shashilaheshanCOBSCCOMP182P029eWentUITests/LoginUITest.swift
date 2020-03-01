//
//  LoginUITest.swift
//  shashilaheshanCOBSCCOMP182P029eWentUITests
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import XCTest
class LoginUITest: XCTestCase {

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

        func testLoginUI() {
            let app = XCUIApplication()
            let elementsQuery = XCUIApplication().scrollViews.otherElements
            let postYourEventsStaticText = elementsQuery.staticTexts["Post your Events"]
            postYourEventsStaticText.swipeLeft()
            postYourEventsStaticText.swipeLeft()
            elementsQuery.buttons["Let's Login"].tap()
            elementsQuery.textFields["Username"].tap()
        
            app.typeText("ebayshashila@gmail.com")
            
            let passwordSecureTextField = elementsQuery.secureTextFields["Password"]
            passwordSecureTextField.tap()
            elementsQuery.buttons["Login"].tap()
            passwordSecureTextField.tap()
            
            
    
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
    }
    func testSliderUI(){
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let element = scrollViewsQuery.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element(boundBy: 0).swipeLeft()
        element.swipeLeft()
        element/*@START_MENU_TOKEN@*/.swipeLeft()/*[[".swipeDown()",".swipeLeft()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        scrollViewsQuery.otherElements.buttons["Let's Login"].tap()
        
    }
    

}
