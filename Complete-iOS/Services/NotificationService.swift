//
//  NotificationManager.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/06.
//

import Foundation
import UIKit
import UserNotifications
import FirebaseMessaging

final class NotificationService: NSObject {
    static let shared = NotificationService()
        
    override init() {
        super.init()
        // MessagingDelegateの指定
        Messaging.messaging().delegate = self
        // UNUserNotificationCenterDelegateの指定
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuth() {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { authorized, error in
            if let error = error {
                logger.permission.error("\(error.localizedDescription)")
            }
            if authorized {
                logger.permission.info("Push notifications allowed.")
            } else {
                logger.permission.warning("Push notifications not allowed.")
            }
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
    
    func registerFCMToken(_ deviceToken: Data?) {
        if let deviceToken = deviceToken {
            Messaging.messaging().apnsToken = deviceToken
        }
    }
}

// MARK: - Firebase Messaging
extension NotificationService: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        guard let fcmToken = fcmToken else { return }
        logger.default.debug("FCMToken: \(String(describing: fcmToken))")
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension NotificationService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // リモート通知かローカル通知かを判別
        if notification.request.trigger is UNPushNotificationTrigger {
            logger.default.debug("willPresent Push Notification")
        } else {
            logger.default.debug("willPresent Local Notification")
        }

        // 通知の ID を取得
        logger.default.info("notification.request.identifier: \(notification.request.identifier)")
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // 通知の情報を取得
        let notification = response.notification

        // リモート通知かローカル通知かを判別
        if notification.request.trigger is UNPushNotificationTrigger {
            logger.default.debug("didReceive Push Notification")
        } else {
            logger.default.debug("didReceive Local Notification")
        }

        // 通知の ID を取得
        logger.default.debug("notification.request.identifier: \(notification.request.identifier)")
        
        completionHandler()
    }
}
