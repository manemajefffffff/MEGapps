//
//  MEGappsViewModelTests.swift
//  MEGappsViewModelTests
//
//  Created by Arya Ilham on 21/03/22.
//

import XCTest
@testable import MEGapps

class AddEditBudgetViewModelTests: XCTestCase {

    var viewModel = AddEditBudgetViewModel()
    var persistentContainer = CoreDataContext.sharedCDC.persistentContainer

    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testAddBudget() throws {
        let context = persistentContainer.viewContext
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        viewModel.saveBudget(name: "Test Budget", amount: 9999)
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Budget add did not occur")
        }
        
    }
    
    func testEditBudget() throws {
        var fetchedBudgets: [Budget] = []
        OtherBudgetCoreDataManager.shared.get { budgets in
            fetchedBudgets = budgets
        }
        let selected = fetchedBudgets.first(where: { budget in
            return budget.name == "Test Budget"
        })
        
        viewModel.oldBudgetData = selected
        expectation(forNotification: .NSManagedObjectContextObjectsDidChange, object: selected?.managedObjectContext) { _ in
            return true
        }
        viewModel.saveBudget(name: "Test Budget Edited", amount: 1111)
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Budget edit did not occur")
        }
    }
    
    // MARK: - Test still buggy
//    func testDeleteBudget() throws {
//        var fetchedBudgets: [Budget] = []
//        OtherBudgetCoreDataManager.shared.get { budgets in
//            fetchedBudgets = budgets
//        }
//        let selected = fetchedBudgets.first(where: { budget in
//            return budget.name == "Test Budget Edited"
//        })
//        viewModel.oldBudgetData = selected
//        expectation(forNotification: .NSManagedObjectContextDidSave, object: selected?.managedObjectContext) { _ in
//            return true
//        }
//        viewModel.deleteBudget()
//        waitForExpectations(timeout: 2.0) { error in
//            XCTAssertNil(error, "Budget delete did not occur")
//        }
//    }
}
