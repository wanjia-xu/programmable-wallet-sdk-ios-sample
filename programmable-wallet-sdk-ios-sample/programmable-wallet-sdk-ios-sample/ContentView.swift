//
//  ContentView.swift
//  programmable-wallet-sdk-ios-sample
//
//  Created by Kevin Chiang on 2023/5/18.
//

import SwiftUI
import CircleProgrammableWalletSDK

struct ContentView: View {

    let adapter = WalletSdkAdapter()

    @State var selectedEndPoint = EndPoint.sandbox
    @State var userToken = ""
    @State var secretKey = ""
    @State var challengeId = ""

    @State var showToast = false
    @State var toastMessage: String?
    @State var toastConfig: Toast.Config = .init()

    var body: some View {
        VStack {
            List {
                titleText
                sectionEndPoint
                sectionInputField("User Token", binding: $userToken)
                sectionInputField("Secret Key", binding: $secretKey)
                sectionInputField("Challenge ID", binding: $challengeId)
                sectionExecuteButton

                Spacer()
                TestButtons
            }
            versionText
        }
        .scrollContentBackground(.hidden)
        .onAppear {
            self.adapter.initSDK(endPoint: selectedEndPoint.urlString)
        }
        .onChange(of: selectedEndPoint) { newValue in
            self.adapter.updateEndPoint(newValue.urlString)
        }
        .toast(message: toastMessage ?? "",
               isShowing: $showToast,
               config: toastConfig)
    }

    var titleText: some View {
        Text("Programmable Wallet SDK\nSample App").font(.title2)
    }

    var versionText: some View {
        Text("v\(Utility.appVersion() ?? "")").font(.footnote)
    }

    var sectionEndPoint: some View {
        Section {
            Picker("End Point", selection: $selectedEndPoint) {
                Text("sandbox").tag(EndPoint.sandbox)
                Text("smokebox").tag(EndPoint.smokebox)
            }
            .pickerStyle(.segmented)
            .frame(width: 200)

        } header: {
            Text("End Point :")
        }
    }

    func sectionInputField(_ title: String, binding: Binding<String>) -> Section<Text, some View, EmptyView> {
        Section {
            TextField(title, text: binding)
                .textFieldStyle(.roundedBorder)
        } header: {
            Text(title + " :")
        }
    }

    var sectionExecuteButton: some View {
        Button {
            guard !userToken.isEmpty else { showToast(.general, message: "User Token is Empty"); return }
            guard !secretKey.isEmpty else { showToast(.general, message: "Secret Key is Empty"); return }
            guard !challengeId.isEmpty else { showToast(.general, message: "Challenge ID is Empty"); return }
            executeChallenge(userToken: userToken, secretKey: secretKey, challengeId: challengeId)

        } label: {
            Text("Execute")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
    }
}

extension ContentView {

    enum ToastType {
        case general
        case success
        case failure
    }

    func showToast(_ type: ToastType, message: String) {
        toastMessage = message
        showToast = true

        switch type {
        case .general:
            toastConfig = Toast.Config()
        case .success:
            toastConfig = Toast.Config(backgroundColor: .green, duration: 2.0)
        case .failure:
            toastConfig = Toast.Config(backgroundColor: .pink, duration: 10.0)
        }
    }

    func executeChallenge(userToken: String, secretKey: String, challengeId: String) {
        WalletSdk.shared.execute(userToken: userToken,
                                 secretKey: secretKey,
                                 challengeIds: [challengeId]) { response in
            switch response.result {
            case .success(let result):
                let challengeStatus = result.status.rawValue
                let challeangeType = result.resultType.rawValue
                showToast(.success, message: "\(challeangeType) - \(challengeStatus)")

            case .failure(let error):
                showToast(.failure, message: "Error: " + error.errorString)
            }
        }
    }

    var TestButtons: some View {
        Section {
            Button("New PIN", action: newPIN)
            Button("Change PIN", action: changePIN)
            Button("Restore PIN", action: restorePIN)
            Button("Enter PIN", action: enterPIN)

        } header: {
            Text("UI Customization Entry")
                .font(.title3)
                .fontWeight(.semibold)
        }
    }

    func newPIN() {
        WalletSdk.shared.execute(userToken: "", secretKey: "", challengeIds: ["ui_new_pin"])
    }

    func enterPIN() {
        WalletSdk.shared.execute(userToken: "", secretKey: "", challengeIds: ["ui_enter_pin"])
    }

    func changePIN() {
        WalletSdk.shared.execute(userToken: "", secretKey: "", challengeIds: ["ui_change_pin"])
    }

    func restorePIN() {
        WalletSdk.shared.execute(userToken: "", secretKey: "", challengeIds: ["ui_restore_pin"])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
