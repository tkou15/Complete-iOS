//
//  Logger.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/10.
//

import Foundation
import OSLog

fileprivate let subsystem = Bundle.main.bundleIdentifier ?? "unknown"

extension Logger {
    static let `default` = Logger(subsystem: subsystem, category: "")
    static let permission = Logger(subsystem: subsystem, category: Category.permission.rawValue)
    
    enum Category: String {
        case `default`
        case permission
    }
}
