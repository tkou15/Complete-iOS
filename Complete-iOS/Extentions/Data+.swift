//
//  Data+.swift
//  Complete-iOS
//
//  Created by Koichi Takahashi on 2024/03/10.
//

import Foundation

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }

    func hexString(options: HexEncodingOptions = []) -> String {
        let hexDigits = options.contains(.upperCase) ? "0123456789ABCDEF" : "0123456789abcdef"
        return map { String(format: "%02\($0 < 0x10 ? "x" : "X")", $0) }.joined()
    }
}
