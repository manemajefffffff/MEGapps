//
//  UseOtherBudgetViewModelTests.swift
//  MEGappsViewModelTests
//
//  Created by Arya Ilham on 27/03/22.
//

import XCTest
@testable import MEGapps

class UseOtherBudgetViewModelTests: XCTestCase {

    var viewModel = UseOtherBudgetViewModel()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel.budgetNotUsed = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel.budgetNotUsed = []
        try super.tearDownWithError()
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testIsUsedStatusChangeToUsed() throws {
        // add dummy data
        let context = OtherBudgetCoreDataManager.shared.persistentContainer.viewContext
        let budget = Budget(context: context)
        budget.name = "Budget for Unit Test"
        budget.amount = 999999
        viewModel.budgetNotUsed.append(BudgetUsed(budget: budget, amountUsed: 1000, isUsed: false))

        for index in 0...viewModel.budgetNotUsed.count - 1 {
            viewModel.changeIsUsedStatus(index: index)
            XCTAssertEqual(viewModel.budgetNotUsed[index].isUsed, true)
        }
    }
    
    func testIsUsedStatusChangeToNotUsed() throws {
        // add dummy data
        let context = OtherBudgetCoreDataManager.shared.persistentContainer.viewContext
        let budget = Budget(context: context)
        budget.name = "Budget for Unit Test"
        budget.amount = 999999
        viewModel.budgetNotUsed.append(BudgetUsed(budget: budget, amountUsed: 1000, isUsed: true))
        
        for index in 0...viewModel.budgetNotUsed.count - 1 {
            viewModel.changeIsUsedStatus(index: index)
            XCTAssertEqual(viewModel.budgetNotUsed[index].isUsed, false)
        }
    }
    
    func testSaveChanges() throws {
        let context = OtherBudgetCoreDataManager.shared.persistentContainer.viewContext
        
        let budget = Budget(context: context)
        budget.name = "Used budget"
        budget.amount = 999999
        viewModel.budgetNotUsed.append(BudgetUsed(budget: budget, amountUsed: 1000, isUsed: true))
        
        let secondBudget = Budget(context: context)
        secondBudget.name = "Not used budget"
        secondBudget.amount = 999999
        viewModel.budgetNotUsed.append(BudgetUsed(budget: secondBudget, amountUsed: 0, isUsed: false))

        viewModel.saveChanges()
        
        // check if budget used is more than 0 and not nil
        XCTAssertNotNil(viewModel.budgetUsed)
        XCTAssertGreaterThan(viewModel.budgetUsed.count, 0)
        
        // check if used budget already removed from budgetNotUsed
        for currentBudget in viewModel.budgetNotUsed {
            XCTAssertFalse(currentBudget.isUsed)
        }
        
        // check if budget that saved is used budget ones and not the unused ones
        for currentBudget in viewModel.budgetUsed {
            XCTAssertTrue(currentBudget.isUsed)
        }
    }
}
