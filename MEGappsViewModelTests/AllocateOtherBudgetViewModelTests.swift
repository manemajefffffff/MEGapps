//
//  AllocateOtherBudgetViewModelTests.swift
//  MEGappsViewModelTests
//
//  Created by Arya Ilham on 27/03/22.
//

import XCTest
@testable import MEGapps

class AllocateOtherBudgetViewModelTests: XCTestCase {
    
    var viewModel = AllocateOtherBudgetViewModel()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel.budgetUsed = []
        viewModel.budgetNotUsed = []
        
        // dummy item
        let item = Items(context: CoreDataContext.sharedCDC.persistentContainer.viewContext)
        item.name = "Test item"
        item.category = "Collections"
        item.isPrioritize = false
        item.deadline = Date()
        item.reason = "Test reason"
        item.price = 99999
        viewModel.item = item
        viewModel.insufficientAmount = item.price
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel.budgetUsed = []
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
    
    func testAllocatedBudgetMoreThanNeeded() throws {
        // given
        let budget = Budget(context: CoreDataContext.sharedCDC.persistentContainer.viewContext)
        budget.name = "Budget for Unit Test"
        budget.amount = 100000
        viewModel.budgetUsed.append(BudgetUsed(budget: budget, amountUsed: 0, isUsed: true))
        
        let second = Budget(context: CoreDataContext.sharedCDC.persistentContainer.viewContext)
        second.name = "Budget for Unit Test"
        second.amount = 100000
        viewModel.budgetUsed.append(BudgetUsed(budget: second, amountUsed: 0, isUsed: true))

        // when
        viewModel.setOtherBudgetUsageAmount(amountUsed: 99999, index: 0)
        viewModel.setOtherBudgetUsageAmount(amountUsed: 100000, index: 1)

        // then
        XCTAssertFalse(viewModel.isBudgetAllocatedEnough)
    }
    
    func testAllocatedBudgetLessThanNeeded() throws {
        // given
        let budget = Budget(context: CoreDataContext.sharedCDC.persistentContainer.viewContext)
        budget.name = "Budget for Unit Test"
        budget.amount = 100000
        viewModel.budgetUsed.append(BudgetUsed(budget: budget, amountUsed: 0, isUsed: true))
        
        let second = Budget(context: CoreDataContext.sharedCDC.persistentContainer.viewContext)
        second.name = "Budget for Unit Test"
        second.amount = 100000
        viewModel.budgetUsed.append(BudgetUsed(budget: second, amountUsed: 0, isUsed: true))

        // when
        viewModel.setOtherBudgetUsageAmount(amountUsed: 100, index: 0)
        viewModel.setOtherBudgetUsageAmount(amountUsed: 1000, index: 1)

        // then
        XCTAssertFalse(viewModel.isBudgetAllocatedEnough)

    }
    
    func testAllocatedBudgetEqualThanNeeded() throws {
        // given
        let budget = Budget(context: CoreDataContext.sharedCDC.persistentContainer.viewContext)
        budget.name = "Budget for Unit Test"
        budget.amount = 100000
        viewModel.budgetUsed.append(BudgetUsed(budget: budget, amountUsed: 0, isUsed: true))
        
        let second = Budget(context: CoreDataContext.sharedCDC.persistentContainer.viewContext)
        second.name = "Budget for Unit Test"
        second.amount = 100000
        viewModel.budgetUsed.append(BudgetUsed(budget: second, amountUsed: 0, isUsed: true))

        // when
        viewModel.setOtherBudgetUsageAmount(amountUsed: 99990, index: 0)
        viewModel.setOtherBudgetUsageAmount(amountUsed: 9, index: 1)

        // then
        XCTAssertTrue(viewModel.isBudgetAllocatedEnough)

    }
    
    func testGetBudget() throws {
        // when
        viewModel.getBudget()

        // then
        XCTAssertNotNil(viewModel.budgetNotUsed)
        XCTAssertGreaterThanOrEqual(viewModel.budgetNotUsed.count, 0)
    }

    // MARK: - Hard to test
    func testProceedWishlist () throws {
        
    }
}
