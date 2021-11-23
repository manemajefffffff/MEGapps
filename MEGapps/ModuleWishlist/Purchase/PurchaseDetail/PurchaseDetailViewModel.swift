//
//  PurchaseDetailViewModel.swift
//  MEGapps
//
//  Created by Aldo Febrian on 05/11/21.
//

import Foundation
import Combine
import UIKit

class PurchaseDetailViewModel {
    let bundle: Bundle
    @Published var item: Items?

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
}

