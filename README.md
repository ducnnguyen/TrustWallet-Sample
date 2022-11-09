# TrustWallet-Sample
This is Sample App using TrustWallet SDK.
You will understand how to create a new wallet or restore an existing one
## iOS
This sample is using SPM but you can also use Cocoapods
### SPM

Download latest `Package.swift` from [GitHub Releases](https://github.com/trustwallet/wallet-core/releases) and put it in a local `WalletCore` folder.

Add this line to the `dependencies` parameter in your `Package.swift`:

```swift
.package(name: "WalletCore", path: "../WalletCore"),
```

Or add remote url + `master` branch, it points to recent (not always latest) binary release.

```swift
.package(name: "WalletCore", url: "https://github.com/trustwallet/wallet-core", .branchItem("master")),
```

Then add libraries to target's `dependencies`: 

```swift
.product(name: "WalletCore", package: "WalletCore"),
.product(name: "SwiftProtobuf", package: "WalletCore"),
```

### CocoaPods

Add this line to your Podfile and run `pod install`:

```ruby
pod 'TrustWalletCore'
```
## Android

### Adding Library Dependency

Android releases are hosted on [GitHub packages](https://github.com/trustwallet/wallet-core/packages/700258), It needs authentication to download packages, please checkout [this guide from GitHub](https://docs.github.com/en/packages/guides/configuring-gradle-for-use-with-github-packages#installing-a-package) for more details.

We recommend to create a non-expiring and readonly token for accessing GitHub packages, and add it to `local.properties` of your Android Studio project locally.

```title='local.properties'
gpr.user=khanh-vo-tiki
gpr.key=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
```

Generate a token [here](https://github.com/settings/tokens):

![Personal Access Token](https://2744446184-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-LeGDgApX5LA1FGVGo-z%2Fuploads%2Fgit-blob-d986d0001b414b2c0abeba5cd815740c50841dca%2Fgithub-packages-token.png?alt=media)

## Usage

## Documentation

For comprehensive documentation, see [developer.trustwallet.com](https://developer.trustwallet.com/wallet-core/integration-guide/wallet-core-usage).