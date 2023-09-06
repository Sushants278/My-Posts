//
//  UserCommentsViewModelTests.swift
//  My PostsTests
//
//  Created by Sushant Shinde on 06.09.23.
//

import XCTest
@testable import My_Posts

class UserCommentsViewModelTests: XCTestCase {
    
    var viewModel: UserCommentsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserCommentsViewModel(userPost: UserPost(userID: 10, id: 12, title: "Sushant", body: "Shinde"))
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: - Mocks
    
    class MockUserPostCommentsViewModelDelegate: UserPostCommentsViewModelDelegate {
        
        var presentUserPostCommentsCalled = false
        var presentFailureScreenCalled = false
        
        func presentUserPostComments() {
            
            presentUserPostCommentsCalled = true
            
        }
        
        func presentFailureScreen() {
            
            presentFailureScreenCalled = true
        }
        
    }
    
    // MARK: - Mocks
    
    class MockNetworkServiceFailure: UserCommentsRequests {
        
        func fetchUserPostComments(for postID: String, handler: @escaping UserCommentsCompletionClosure) {
            
            handler(nil, NetworkError.invalidData)
        }
    }
    
    class MockNetworkService: UserCommentsRequests {
        
        func fetchUserPostComments(for postID: String, handler: @escaping UserCommentsCompletionClosure) {
            
            handler([UserComment(postID: 10, id: 12, name: "Sushant", email: "Shinde@mail.com", body: "All are okay")], nil)
            
        }
    }
  
    // MARK: - Test Cases
    
    func testFetchUserPostsSuccess() {
        
        //Given
        let mockDelegate = MockUserPostCommentsViewModelDelegate()
        viewModel.delegate = mockDelegate
        let mockNetworkService = MockNetworkService()
        viewModel.networkService = mockNetworkService
        
        //when
        viewModel.fetchCommentsForPost()
        
        //Then
        XCTAssertTrue(mockDelegate.presentUserPostCommentsCalled)
    }
    
    func testFetchUserPostsFailure() {
        
        //Given
        let mockDelegate = MockUserPostCommentsViewModelDelegate()
        viewModel.delegate = mockDelegate
        let mockNetworkService = MockNetworkServiceFailure()
        viewModel.networkService = mockNetworkService
        
        //when
        viewModel.fetchCommentsForPost()
        
        //Then
        XCTAssertTrue(mockDelegate.presentFailureScreenCalled)
    }
}
