//
//  ContentView.swift
//  programmable-wallet-sdk-ios-sample
//
//  Created by Kevin Chiang on 2023/5/18.
//

import SwiftUI
import CircleProgrammableWalletSDK

struct ContentView: View {

    let appId = "programmable-wallet-sdk-ios-sample" // temporary input a random string before production

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
            }
            versionText
        }
        .scrollContentBackground(.hidden)
        .onAppear {
            let configuration = WalletSdk.Configuration(endPoint: selectedEndPoint.urlString, appId: appId)
            WalletSdk.shared.setConfiguration(configuration)
        }
        .onChange(of: selectedEndPoint) { newValue in
            let configuration = WalletSdk.Configuration(endPoint: newValue.urlString, appId: appId)
            WalletSdk.shared.setConfiguration(configuration)
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

            WalletSdk.shared.execute(userToken: userToken, secretKey: secretKey, challengeIds: [challengeId]) { arr, result in
                switch result {
                case .success(let result):
                    let challengeStatus = result.status.rawValue
                    let challeangeType = result.resultType.rawValue
                    showToast(.success, message: "\(challeangeType) - \(challengeStatus)")

                case .failure(let error):
                    showToast(.failure, message: error.errorString)
                }
                return nil
            }

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}