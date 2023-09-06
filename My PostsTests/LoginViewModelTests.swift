//
//  LoginViewModelTests.swift
//  My PostsTests
//
//  Created by Sushant Shinde on 06.09.23.
//

import XCTest

@testable import My_Posts

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Mocks
    
    class MockLoginViewModelDelegate: LoginViewModelDelegate {
        
        var presentLoginSuccessfulCalled = false
        var presentLoginFailureCalled = false
        
        func presentLoginSuccessful() {
            
            presentLoginSuccessfulCalled = true
        }
        
        func presentLoginFailure() {
            
            presentLoginFailureCalled = true
        }
    }
    
    func testPresentLoginSuccessful() {
        
        //Given
        let mockDelegate = MockLoginViewModelDelegate()
        viewModel.delegate = mockDelegate
        
        //when
        viewModel.loginWith(userID: "5")
        
        //Then
        XCTAssertTrue(mockDelegate.presentLoginSuccessfulCalled)
    }
    
    func testPresentLoginFailure() {
        
        //Given
        let mockDelegate = MockLoginViewModelDelegate()
        viewModel.delegate = mockDelegate
        
        //when
        viewModel.loginWith(userID: "0")
        
        //Then
        XCTAssertTrue(mockDelegate.presentLoginFailureCalled)
    }
    
}
