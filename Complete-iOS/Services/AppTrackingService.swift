//
//  AppTrackingService.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/06.
//

import Foundation
import AppTrackingTransparency
import AdSupport

class AppTrackingService {
    
    static let shared = AppTrackingService()
    
    func requestAppTrackingTransparencyAuthorization() {
        if #available(iOS 14.5, *) {
            // .notDeterminedの場合にだけリクエスト呼び出しを行う
            guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else { return }
            // タイミングを遅らせる為に処理を遅延させる
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                    switch status {
                    case .authorized:
                        let idfa = ASIdentifierManager.shared().advertisingIdentifier
                        print(idfa.uuidString)
                    default:
                        print("IDFA could not be obtained.")
                    }
                })
            }
        }
    }
}
