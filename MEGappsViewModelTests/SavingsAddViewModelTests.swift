//
//  SavingsAddViewModelTests.swift
//  MEGappsViewModelTests
//
//  Created by Arya Ilham on 24/03/22.
//

import XCTest
@testable import MEGapps

class SavingsAddViewModelTests: XCTestCase {
    var viewModel = SavingsAddViewModel()
    let persistentContainer = CoreDataContext.sharedCDC.persistentContainer
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchData() throws {
        viewModel.fetchData()
        XCTAssertNotNil(viewModel.savingsHistory)
    }

    func testAddSavings() throws {
        let context = persistentContainer.viewContext
        viewModel.isAdd = true
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        viewModel.saveSavingsAmount(createdDate: Date(), amount: 9999)
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Savings not added")
        }
    }
    
    func testDeductSavings() throws {
        let context = persistentContainer.viewContext
        viewModel.isAdd = false
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        viewModel.saveSavingsAmount(createdDate: Date(), amount: 9999)
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Savings not deducted")
        }

    }
    
}
