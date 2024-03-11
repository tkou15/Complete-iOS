//
//  AppDelegate.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/05.
//

import UIKit
import FirebaseCore
import FirebaseMessaging
import OSLog

let logger = Logger.self

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.setupFirebase()
        self.setupNotification()
        self.setupAtt()
        return true
    }
    
    /// Firebaseの初期設定
    private func setupFirebase() {
        FirebaseApp.configure()
    }
    
    /// ATTの権限取得
    private func setupAtt() {
        AppTrackingService.shared.requestAppTrackingTransparencyAuthorization()
    }
    
    // 通知の権限取得
    private func setupNotification() {
        NotificationService.shared.requestAuth()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NotificationService.shared.registerFCMToken(deviceToken)
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print(token)
        print(deviceToken.hexString())
        logger.default.debug("Device Token: \(token)")
    }
}

