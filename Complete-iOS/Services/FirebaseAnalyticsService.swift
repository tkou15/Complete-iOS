//
//  FirebaseSerivce.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/06.
//

import Foundation
import FirebaseAnalytics

struct AnalyticsService {
    enum AnalyticsEvent: String {
        case sample = "sample_event"
        
        var name: String {
            return self.rawValue
        }
    }
    
    static func logEvent(_ event: AnalyticsEvent, parameters: [String: Any]? = nil) {
        Analytics.logEvent(event.name, parameters: parameters)
    }
}
