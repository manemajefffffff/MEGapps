//
//  NotificationService.swift
//  MEGapps
//
//  Created by Arya Ilham on 16/11/21.
//

import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    // MARK: - Function
    func createNewWishlistAddNotification(itemName: String, notificationId: UUID) {
        let content = createNotificationContent(title: "Waiting is Over", body: "\(itemName) are waiting to be accepted")
        let trigger = createTriggerForTomorrow()
        let request = createNotificationRequest(
            content: content,
            trigger: trigger,
            notificationId: notificationId)
        addNotificationRequest(request: request)
    }
    
    // MARK: - Private func
    private func createNotificationContent(title: String, body: String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        return content
    }
    
    private func createTriggerForTomorrow() -> UNCalendarNotificationTrigger {
        let fromDate = Date(timeIntervalSince1970: Double(0.0))

        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: fromDate)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        print(trigger.nextTriggerDate() ?? "nil")
        
        return trigger
    }
    
    private func createNotificationRequest(content: UNMutableNotificationContent, trigger: UNCalendarNotificationTrigger, notificationId: UUID) -> UNNotificationRequest {
        let uuidString = notificationId.uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        return request
    }
    
    private func addNotificationRequest(request: UNNotificationRequest) {
        UNUserNotificationCenter.current().add(request) { error in
            if let err = error {
                fatalError("\(err)")
            } else {
                print("scheduled")
            }
        }
    }
}
