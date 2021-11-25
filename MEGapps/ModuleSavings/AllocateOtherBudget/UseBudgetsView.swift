//
//  UseBudgetView.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 25/11/21.
//

import Foundation
import UIKit

class UseBudgetsView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var useBudgetTableView: UITableView!
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func dismissPage(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBudget(_ sender: Any) {
        
    }
    
}

extension UseBudgetsView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = useBudgetTableView.dequeueReusableCell(withIdentifier: "useBudgetCell") as? UseBudgetCell else {
            fatalError("no cell found")
        }
        return cell
    }
}

class UseBudgetCell: UITableViewCell {
    @IBOutlet weak var budgetNameLabel: UILabel!
    @IBOutlet weak var budgetLeftLabel: UILabel!
}
