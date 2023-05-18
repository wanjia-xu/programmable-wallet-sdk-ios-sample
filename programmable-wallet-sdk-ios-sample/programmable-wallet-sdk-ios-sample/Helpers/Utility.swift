//
//  Utility.swift
//  programmable-wallet-sdk-ios-sample
//
//  Created by Kevin Chiang on 2023/5/18.
//

import Foundation

struct Utility {

    static func appVersion() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }

    static func appBuildNumber() -> String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }

}
