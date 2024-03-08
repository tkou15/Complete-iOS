//
//  AppDelegate.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/05.
//

import UIKit
import FirebaseCore

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        self.setupAtt()
        return true
    }
    
    private func setupAtt() {
        AppTrackingService.shared.requestAppTrackingTransparencyAuthorization()
    }
}

