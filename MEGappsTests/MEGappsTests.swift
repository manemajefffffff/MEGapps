//
//  MEGappsTests.swift
//  MEGappsTests
//
//  Created by Arya Ilham on 26/10/21.
//

import XCTest
@testable import MEGapps

class MEGappsTests: XCTestCase {
    var pav: WishlistAddView!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "WishlistAdd", bundle: nil)
        pav = storyboard.instantiateViewController(withIdentifier: "WishlistAddView") as? WishlistAddView
        pav.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        pav = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
