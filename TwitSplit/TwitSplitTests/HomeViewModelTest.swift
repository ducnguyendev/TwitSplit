//
//  HomeViewModelTest.swift
//  TwitSplitTests
//
//  Created by Duc Nguyen on 3/2/18.
//  Copyright © 2018 Duc Nguyen. All rights reserved.
//

import XCTest
@testable import TwitSplit
class HomeViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLessThan50(){
        let viewModel = HomeViewModel()
        let lessThan50Message = "I can't believe Tweeter now supports chunking"
        let (messageChunks,hasError) = viewModel.splitMessage(message: lessThan50Message)
        XCTAssertEqual(messageChunks.count,1)
        XCTAssertFalse(hasError)
        
    }
    
    func testSplitMessage() {
        let viewModel = HomeViewModel()
        let lessThan50Message = "I can not believe Tweeter now supports chunking my messages, so I don't have to do it myself."
        let (messageChunks,hasError) = viewModel.splitMessage(message: lessThan50Message)
        XCTAssertEqual(messageChunks.count,2)
        XCTAssertFalse(hasError)
    }
    
    func testSplitMessageWithError() {
        let viewModel = HomeViewModel()
        let lessThan50Message = "012345678901234567890123456789012345678901234567890"
        let (_,hasError) = viewModel.splitMessage(message: lessThan50Message)
        XCTAssertTrue (hasError)
    }
    
}
