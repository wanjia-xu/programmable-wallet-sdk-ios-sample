//
//  WalletSdkAdapter.swift
//  programmable-wallet-sdk-ios-sample
//
//  Created by Kevin Chiang on 2023/5/23.
//

import UIKit
import CircleProgrammableWalletSDK

class WalletSdkAdapter {

    let appId = "programmable-wallet-sdk-ios-sample" // temporary input a random string before production

    func initSDK(endPoint: String) {
        self.updateEndPoint(endPoint)

        WalletSdk.shared.setLayoutProvider(self)
        WalletSdk.shared.setDelegate(self)
    }

    func updateEndPoint(_ endPoint: String) {
        let configuration = WalletSdk.Configuration(endPoint: endPoint, appId: appId)
        WalletSdk.shared.setConfiguration(configuration)
    }
}

extension WalletSdkAdapter: WalletSdkLayoutProvider {

    func securityQuestions() -> [SecurityQuestion] {
        return [
            SecurityQuestion(title: "What is your childhood nickname?", inputType: .text),
            SecurityQuestion(title: "What is the middle name of your oldest child?", inputType: .text),
            SecurityQuestion(title: "What is your favorite team?", inputType: .text),
            SecurityQuestion(title: "When was your birthday?", inputType: .datePicker),
            SecurityQuestion(title: "When is your marriage anniversary?", inputType: .datePicker),
        ]
    }

    func securityQuestionsRequiredCount() -> Int {
        return 3
    }

    func securityConfirmItems() -> [SecurityConfirmItem] {
        return [
            SecurityConfirmItem(image: UIImage(named: "img_info"),
                                text: "This is the only way to recover my account access."),
            SecurityConfirmItem(image: UIImage(named: "img_claim_success"),
                                text: "Circle won’t store my answers so it’s my responsibility to remember them."),
            SecurityConfirmItem(image: UIImage(named: "img_claim_success"),
                                text: "I will lose access to my wallet and my digital assets if I forget my answers."),
        ]
    }

    func imageStore() -> ImageStore {
        let local: [ImageStore.Img: UIImage] = [
            .naviBack: UIImage(named: "ic_navi_back")!,
            .naviClose: UIImage(named: "ic_navi_close")!,
            .selectCheckMark: UIImage(named: "ic_checkmark")!,
            .dropdownArrow: UIImage(named: "ic_trailing_down")!,
            .errorInfo: UIImage(named: "ic_warning_alt")!,
            .securityIntroMain: UIImage(named: "img_security_intro")!,
            .securityConfirmMain: UIImage(named: "img_driver_blog")!
        ]

        let remote: [ImageStore.Img : URL] = [:]

        return ImageStore(local: local, remote: remote)
    }

    func displayDateFormat() -> String {
        return "yyyy/MM/dd"
    }
}


extension WalletSdkAdapter: WalletSdkDelegate {

    func walletSdk(willPresentController controller: UIViewController) {
        print("willPresentController: \(controller)")
    }

    func walletSdk(controller: UIViewController, onForgetPINButtonSelected onSelect: Void) {
        print("onForgetPINButtonSelected")
    }
}
