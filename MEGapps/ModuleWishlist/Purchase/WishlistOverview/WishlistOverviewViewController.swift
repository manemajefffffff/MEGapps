//
//  WishlistOverviewViewController.swift
//  MEGapps
//
//  Created by Adinda Puji Rahmawaty on 28/10/21.
//

import UIKit

class WishlistOverviewViewController: UIViewController {
    
//    func changepiHeight(piHeight: CGFloat) {
//        DispatchQueue.main.async {
//            self.productInfoHeight?.constant = piHeight
//            self.productInfoUiView.layoutIfNeeded()
//        }
//    }
//
    // MARK: Outlets
//    @IBOutlet weak var productInfoHeight: NSLayoutConstraint!
//    @IBOutlet weak var productInfoUiView: UIView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    @IBOutlet weak var reasonUIView: UIView!
    
    // MARK: Variables
    var wishlistAdd: WishlistAddViewModel? {
        didSet {
        }
    }
    
    // MARK: View
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: Buttons
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addToWishlistButton(_ sender: Any) {
       addToWishlistPressed()
    }
    
    @IBAction func cancelWishlistButton(_ sender: Any) {
        cancelWishlistPressed()
    }
    
    // MARK: Functions
    private func addToWishlistPressed() {
        let alert = UIAlertController(title: "Add to Wishlist", message: "Are you sure you want to add this item into your wishlist?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: saveNewWishlist))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func cancelWishlistPressed() {
        let alert = UIAlertController(title: "Cancel Wishlist", message: "Are you sure you want to cancel this item into your wihslist?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Confirm", style: UIAlertAction.Style.default, handler: cancalAddingWishlist))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func saveNewWishlist(alert: UIAlertAction) {
        wishlistAdd?.saveNewWishlist()
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func cancalAddingWishlist(alert: UIAlertAction) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        productNameLabel.text = wishlistAdd?.items?.name
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if let price = wishlistAdd?.items?.price {
            if let formattedPrice = formatter.string(from: price as NSNumber) {
                priceLabel.text = "Rp. \(formattedPrice)"
            }
        }

        categoryLabel.text = wishlistAdd?.items?.category
        reasonLabel.text =  wishlistAdd?.items?.reason
        
        reasonUIView.layer.shadowColor = UIColor.lightGray.cgColor
        reasonUIView.layer.shadowOffset = CGSize(width: 0, height: 3)
        reasonUIView.layer.shadowRadius = 2.0
        reasonUIView.layer.shadowOpacity = 0.4
        reasonUIView.layer.masksToBounds = false
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "ProductSegue"{
//            guard let dest = segue.destination as? ProductInformationTableViewController else {
//                fatalError()
//            }
//            dest.delegate = self
//            dest.item = wishlistAdd?.items
//            return
//        }
//    }
    
}
