//
//  ViewModel.swift
//  MEGapps
//
//  Created by Aldo Febrian on 27/10/21.
//

import Foundation
import Combine
import UIKit

class WishlistDetailViewModel {
    // @Published var model: //DataModel
    let bundle: Bundle
    
    @Published var wishlist = Items()

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }
    
    func acceptWishlist() {
        WishlistCoreDataManager.shared.acceptWishlist(wishlist)
        if let notificationId = wishlist.wishlistNotificationId {
            NotificationService.shared.deleteNotification(notificationId: notificationId)
        }
    }
    
    func cancelWishlist() {
        WishlistCoreDataManager.shared.cancelWishlist(wishlist)
        if let notificationId = wishlist.wishlistNotificationId {
            NotificationService.shared.deleteNotification(notificationId: notificationId)
        }
    }
}
