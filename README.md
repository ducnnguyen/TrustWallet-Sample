# TrustWallet-Sample

## iOS

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