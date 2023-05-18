//
//  EndPoint.swift
//  programmable-wallet-sdk-ios-sample
//
//  Created by Kevin Chiang on 2023/5/18.
//

import Foundation

enum EndPoint {
    case sandbox
    case smokebox

    var urlString: String {
        switch self {
        case .sandbox: return "https://api-sandbox.circle.com/v1/w3s"
        case .smokebox: return "https://api-smokebox.circle.com/v1/w3s"
        }
    }
}
