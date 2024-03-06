//
//  NotificationManager.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/06.
//

import Foundation
import UserNotifications

final class NotificationManager: NSObject {
    static let shared = NotificationManager()
    
    override init() {
        super.init()
    }
    
    func requestAuth() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { authorized, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            } else {
                // TODO: Handle authorized.
            }
        }
    }
}

// -- MARK: UNUserNotificationCenterDelegate
extension NotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // リモート通知かローカル通知かを判別
        if notification.request.trigger is UNPushNotificationTrigger {
            print("willPresent Push Notification")
        } else {
            print("willPresent Local Notification")
        }

        // 通知の ID を取得
        print("notification.request.identifier: \(notification.request.identifier)")
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 通知の情報を取得
        let notification = response.notification

        // リモート通知かローカル通知かを判別
        if notification.request.trigger is UNPushNotificationTrigger {
            print("didReceive Push Notification")
        } else {
            print("didReceive Local Notification")
        }

        // 通知の ID を取得
        print("notification.request.identifier: \(notification.request.identifier)")
        
        completionHandler()
    }
}
