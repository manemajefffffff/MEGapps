//
//  PurchaseOtherBudgetAllocationViewController.swift
//  MEGapps
//
//  Created by Arya Ilham on 29/10/21.
//

import UIKit

class PurchaseOtherBudgetAllocationViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var otherBudgetAllocationTableView: UITableView!
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        registerGesture()
    }
    // MARK: - Function
    private func registerNib() {
        otherBudgetAllocationTableView.register(UINib.init(nibName: "PurchaseAllocateBudgetTableViewCell", bundle: nil), forCellReuseIdentifier: "PurchaseAllocateBudgetTableViewCell")
    }
    private func setupTableDropShadow() {
        let containerView: UIView = UIView(frame: self.otherBudgetAllocationTableView.frame)
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.lightGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowRadius = 2

        otherBudgetAllocationTableView.layer.cornerRadius = 10
        otherBudgetAllocationTableView.layer.masksToBounds = true
        self.view.addSubview(containerView)
        containerView.addSubview(otherBudgetAllocationTableView)
    }
    private func registerGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension PurchaseOtherBudgetAllocationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = otherBudgetAllocationTableView
                .dequeueReusableCell(
                    withIdentifier: "PurchaseAllocateBudgetTableViewCell", for: indexPath)
                as? PurchaseAllocateBudgetTableViewCell else {
                    fatalError("no table cell found")
                }
        
        return cell
    }
    
    
}
