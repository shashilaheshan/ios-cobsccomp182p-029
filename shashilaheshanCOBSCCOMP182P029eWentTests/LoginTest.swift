//
//  LoginTest.swift
//  shashilaheshanCOBSCCOMP182P029eWentTests
//
//  Created by Shashila Heshan on 1/3/20.
//  Copyright © 2020 Shashila Heshan. All rights reserved.
//

import XCTest

@testable import shashilaheshanCOBSCCOMP182P029eWent

class LoginTest: XCTestCase {
    
    var loginviewModel:LoginViewModel!
    var authDataService  :AuthDataService!
    //dummy user credentials
    var email:String = "ebayshashila@gmail.com"
    var password:String = "12345678"

    override func setUp() {
       self.loginviewModel = LoginViewModel()
       self.authDataService = AuthDataService()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginDataIsCorrect() {
       
        //validated to email and password should be atleast 8 chars long
         XCTAssertEqual(self.loginviewModel.validateLoginCredentials(email: self.email, password: self.password),true)
        
        
    }
    func testIsLoginSuccess() {
        
        self.loginviewModel.email = self.email
        self.loginviewModel.password = self.password
          //since this is an async task we need to add axpectation to Test 
        let expectation = self.expectation(description: "Login")
        
        var authed :Bool!
        
        self.authDataService.loginUser(user: User(lvm: self.loginviewModel)) { success, loading in
         
            authed = success
            
            expectation.fulfill()
           
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(authed, true)
      
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
