# programmable-wallet-sdk-ios-sample
This is a sample project for iOS beginners to integrate with CircleProgrammableWalletSDK.

- Bookmark
  - [Requirements](#requirements)
  - [Installation](#installation)
  - [Run the project](#run-the-project)
---

## Requirements

### Xcode
[Xcode](https://apps.apple.com/tw/app/xcode/id497799835?mt=12) consists of a suite of tools that developers use to build apps for Apple platforms. Use Xcode to manage your entire development workflow — from creating your app to testing, optimizing, and submitting it to the App Store.

### CocoaPods
[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website.

### SSH key
Shared [SSH key](https://share.1password.com/s#bzIRVj59HVFKzKj1LbZToCDh10DyPVlRKTmhFbVqmuo) for PW SDK Hackathon

<img src="readme_images/screenshot_1.png" width="400"/>

> How to setup an exist SSH key? : see [this](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent)

1. `$ vi ~/.ssh/{your SSH key name}`, then paste the private key
2. `$ chmod 400 ~/.ssh/{your SSH key name}`
3. Open your `~/.ssh/config` file, then modify the file to contain the following lines.
    ```default
    Host bitbucket.com
      AddKeysToAgent yes
      UseKeychain yes
      IdentityFile ~/.ssh/{your SSH key name}
    ```
4. `$ ssh-add --apple-use-keychain ~/.ssh/{your SSH key name}`

## Installation

1. Clone this repo
2. Open project folder `$ cd programmable-wallet-sdk-ios-sample`
3. Run `$ pod install` to install `CircleProgrammableWalletSDK`
4. Run `$ pod update` to update `CircleProgrammableWalletSDK` (Optional)
5. Open the `programmable-wallet-sdk-ios-sample.xcworkspace` in Xcode
<img src="readme_images/screenshot_2.png" width="400"/>

## Run the project

1. Select a simulator as run target
2. press `Run` button (Command + R)
![image](readme_images/screenshot_3.png)
