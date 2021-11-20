//
//  OtherBudgetViewModel.swift
//  MEGapps
//
//  Created by Arya Ilham on 20/11/21.
//

import Foundation
import Combine

class OtherBudgetViewModel: NSObject {
    
    @Published var otherBudget = [Budget]()
    
    override init() {
        super.init()
        self.fetchData()
    }
    
    private func fetchData() {
        
    }
    
}
