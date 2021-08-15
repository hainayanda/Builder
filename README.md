# Builder

Builder is Swift builder pattern library that utilize dynamicCallable and dynamicMemberLookup as its core.

![build](https://github.com/hainayanda/Builder/workflows/build/badge.svg)
![test](https://github.com/hainayanda/Builder/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/Builder.svg?style=flat)](https://cocoapods.org/pods/Builder)
[![License](https://img.shields.io/cocoapods/l/Builder.svg?style=flat)](https://cocoapods.org/pods/Builder)
[![Platform](https://img.shields.io/cocoapods/p/Builder.svg?style=flat)](https://cocoapods.org/pods/Builder)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.1 or higher (or 5.3 when using Swift Package Manager)
- iOS 10 or higher

### Only Swift Package Manager

- macOS 10.10 or higher
- tvOS 10 or higher

## Installation

### Cocoapods

Builder is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'Builder', '~> 1.0.0'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **https://github.com/hainayanda/Builder.git** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **1.0.3** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
  .package(url: "https://github.com/hainayanda/Builder.git", .upToNextMajor(from: "1.0.0"))
]
```

Use it in your target as `Builder`

```swift
 .target(
  name: "MyModule",
  dependencies: ["Builder"]
)
```

## Author

Nayanda Haberty, hainayanda@outlook.com

## License

Impose is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Basic Usage

Using Builder is simple. You just need to pass the object you want to build and assign its writable property as its a function. Example:

If you have a class like this:

```swift
class MyObject {
    var string: String
    var int: Int
    var double: Double
    
    ...
    ...
}
```

you can build it like this:

```swift
let myObject: MyObject = builder(MyObject())
    .string("some string")
    .int(10)
    .double(1.2)
    .build()
```

Its even can assign property of property as deep as you need:

```swift
let view: UIView = builder(UIView())
    .backgroundColor(.white)
    .layer.cornerRadius(16)
    .build()
```

## Buildable

There's a protocol named Buildable which declared like this:

```swift
public protocol Buildable {
    init()
}
```

its just to ensure you can call builder global function by only passing its `Type`:

```swift
```swift
let view: UIView = builder(UIView.self)
    .backgroundColor(.white)
    .layer.cornerRadius(16)
    .build()
```

`NSObject` by default is implemented this protocol, so `UIView`, `UIViewController` and many things can be build like this.
You can always implemented it to your object.

## Contribute

You know how, just clone and do pull request
