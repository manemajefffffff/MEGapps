//
//  PurchaseAddViewModel.swift
//  MEGapps
//
//  Created by Hannatassja Hardjadinata on 10/11/21.
//

import Foundation
import Combine

class WishlistAddViewModel: NSObject {
    var items: WishlistAdd?
    
    override init() {
        self.items = WishlistAdd()
    }
    
    func saveNewWishlist() {
        // save ke coredata
        if let toBeSavedItems = items {
            WishlistCoreDataManager.shared.saveNewWishlist(toBeSavedItems) { message in
                switch message {
                case "success":
                    // buat notification
                    NotificationService.shared.createNewWishlistAddNotification(
                        itemName: toBeSavedItems.name,
                        notificationId: toBeSavedItems.notificationId)
                case "failed":
                    // handler kalau insert coredata gagal
                    fatalError("failed to insert new wishlist")
                default:
                    break
                }
            }
        }
    }
}
