//
//  WishlistOverviewViewController.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 28/10/21.
//

import UIKit

class WishlistOverviewViewController: UIViewController, ProductInformationTVCProtocol {
    func changepiHeight(piHeight: CGFloat) {
        DispatchQueue.main.async {
            self.productInfoHeight?.constant = piHeight
            self.productInfoUiView.layoutIfNeeded()
        }
    }
    
    // MARK: Outlets
    @IBOutlet weak var productInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var productInfoUiView: UIView!
    
    // MARK: Variables
    var wishlistAdd: WishlistAddViewModel? {
        didSet {
        }
    }
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Buttons
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addToWishlistButton(_ sender: Any) {
       addToWishlistPressed()
    }
    
    @IBAction func cancelWishlistButton(_ sender: Any) {
        cancelWishlistPressed()
    }
    
    // MARK: Functions
    private func addToWishlistPressed() {
        let alert = UIAlertController(title: "Add Item", message: "Are you sure you want to add this item?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: saveNewWishlist))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func cancelWishlistPressed() {
        let alert = UIAlertController(title: "Cancel Purchase", message: "Are you sure you want to cancel this item?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveNewWishlist(alert: UIAlertAction) {
        wishlistAdd?.saveNewWishlist()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProductSegue"{
            guard let dest = segue.destination as? ProductInformationTableViewController else {
                fatalError()
            }
            dest.delegate = self
            dest.item = wishlistAdd?.items
            return
        }
    }
    
}
