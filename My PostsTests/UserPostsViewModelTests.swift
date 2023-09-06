//
//  UserPostsViewModelTests.swift
//  My PostsTests
//
//  Created by Sushant Shinde on 05.09.23.
//

import XCTest

import XCTest
@testable import My_Posts

class UserPostsViewModelTests: XCTestCase {

    var viewModel: UserPostsViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = UserPostsViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: - Mocks
    
    class MockUserPostsViewModelDelegate: UserPostsViewModelDelegate {
        
        var presentUserPostsCalled = false
        var presentFailureScreenCalled = false
        var presentUpdatedUserPostsCalled = false
        
        func presentUserPosts() {
            
            presentUserPostsCalled = true
        }

        func presentFailureScreen() {
            
            presentFailureScreenCalled = true
        }

        func presentUpdatedUserPosts(indexPath: IndexPath) {
            
            presentUpdatedUserPostsCalled = true
        }
    }
    
    // MARK: - Mocks
    
    class MockNetworkServiceFailure: UserPostsRequests {

        func fetchUserPosts(for userID: String, handler completion: @escaping (UserPosts?, Error?) -> Void) {
            
            completion(nil, NetworkError.invalidData)
        }
    }
    
    class MockNetworkService: UserPostsRequests {
        
        var error: Error?

        func fetchUserPosts(for userID: String, handler completion: @escaping (UserPosts?, Error?) -> Void) {
            
            completion([UserPost(userID: 1, id: 2, title: "Sushant", body: "Hello How are you")], error)
        }
    }

    // MARK: - Test Cases

    func testFetchUserPostsSuccess() {
        
        //Given
        let mockDelegate = MockUserPostsViewModelDelegate()
        viewModel.userPostsViewModelDelegate = mockDelegate
        let mockNetworkService = MockNetworkService()
        viewModel.networkService = mockNetworkService
        UserManager.shared.saveUserID("5")

        //when
        viewModel.fetchUserPosts()

        //Then
        XCTAssertTrue(mockDelegate.presentUserPostsCalled)
    }

    func testFetchUserPostsFailure() {
        
        //Given
        let mockDelegate = MockUserPostsViewModelDelegate()
        viewModel.userPostsViewModelDelegate = mockDelegate
        let mockNetworkService = MockNetworkServiceFailure()
        viewModel.networkService = mockNetworkService
        UserManager.shared.saveUserID("5")
        
        //when
        viewModel.fetchUserPosts()

        //Then
        XCTAssertTrue(mockDelegate.presentFailureScreenCalled)
    }

    func testShowAllUserPosts() {
       
        //when
        viewModel.showAllOrFavoriteUserPosts(isShowFavorite: false)
        
        //Then
        XCTAssertTrue(viewModel.isShowAllUserPosts)
        
    }
    
    func testShowFavoriteUserPosts() {
       
        //when
        viewModel.showAllOrFavoriteUserPosts(isShowFavorite: true)
        
        //Then
        XCTAssertFalse(viewModel.isShowAllUserPosts)
    }
    
    func testSaveFavoritePost() {
         // Given
        let mockDelegate = MockUserPostsViewModelDelegate()
        viewModel.userPostsViewModelDelegate = mockDelegate
         let userPost = UserPost(userID: 1, id: 1, title: "Test Title", body: "Test Body", isFavorite: false)
        
        viewModel.userPosts = [userPost]
        viewModel.isShowAllUserPosts = true
         
         // When
         viewModel.favoritePost(userPost: userPost)
         
         // Then
        XCTAssertTrue(mockDelegate.presentUpdatedUserPostsCalled)
     }
    
    func testRemoveFavoritedPost() {
         // Given
        let mockDelegate = MockUserPostsViewModelDelegate()
        viewModel.userPostsViewModelDelegate = mockDelegate
         let userPost = UserPost(userID: 1, id: 1, title: "Test Title", body: "Test Body", isFavorite: false)
        
        viewModel.userPosts = [userPost]
        viewModel.isShowAllUserPosts = false
         
         // When
         viewModel.favoritePost(userPost: userPost)
         
         // Then
        XCTAssertTrue(mockDelegate.presentUserPostsCalled)
     }
     
 }
