//
//  EventTest.swift
//  shashilaheshanCOBSCCOMP182P029eWentTests
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import XCTest
@testable import shashilaheshanCOBSCCOMP182P029eWent
class EventTest: XCTestCase {

    var eventViewModel:EventViewModel!
    
    var eventDataService:EventDataService = EventDataService()
    
    override func setUp() {
        self.eventViewModel = EventViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEventCanAdded(){
        self.eventViewModel.event_name = "Dummy event"
        self.eventViewModel.event_location = Location(name: "Thummulla", lat: 8.89, lng: 78.9)
        self.eventViewModel.description = "Test Event"
        self.eventViewModel.datetime = "02-03-2020 12:13:12"
        self.eventViewModel.eventImages = UIImage(named: "slider1")
        self.eventViewModel.eventId = ""
        self.eventViewModel.imgURL = ""
        
        var added:Bool!
        //since this is an async task we need to add axpectation to Test
        let expectation = self.expectation(description: "EventAdd")
        
        self.eventDataService.saveEventData(event: Event(eVM: self.eventViewModel)) { (String, Bool) in
            
            added = Bool
            
            expectation.fulfill()
            
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(added, false)
    }
    

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
