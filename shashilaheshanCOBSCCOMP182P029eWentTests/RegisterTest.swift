//
//  RegisterTest.swift
//  shashilaheshanCOBSCCOMP182P029eWentTests
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import XCTest
@testable import shashilaheshanCOBSCCOMP182P029eWent
class RegisterTest: XCTestCase {

    var registerModel:RegisterViewModel!
    var authDataService : AuthDataService = AuthDataService()
    
    override func setUp() {
        self.registerModel = RegisterViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    //here we are not going to
    func testUserCanRegister() {
        self.registerModel.batch = "192P"
        self.registerModel.email = "dummy@mail.com"
        self.registerModel.password = "12345678"
        self.registerModel.fullName = "Dummy user"
        self.registerModel.image_url = ""
        self.registerModel.image = UIImage(named: "slider1")
        
        var registered:Bool!
        //since this is an async task we need to add axpectation to Test 
           let expectation = self.expectation(description: "Register")
        
        self.authDataService.registerUser(user: User(rvm: self.registerModel)) { (success, loading) in
            
            registered = success
            
            expectation.fulfill()
            
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(registered, true)
        
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
