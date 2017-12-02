# KeyboardFriendlyScrolling

![Swift version](https://img.shields.io/badge/swift-4.0-orange.svg)
![CocoaPods compatible](https://cocoapod-badges.herokuapp.com/v/KeyboardFriendlyScrolling/badge.png)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


Protocol extension for UIViewController to manage scroll view content insets depending on keyboard frame

## Usage
[Example](https://github.com/morishin/KeyboardFriendlyScrolling/tree/master/Example)
```swift
import UIKit
import KeyboardFriendlyScrolling

class ViewController: UIViewController, KeyboardFriendlyScrolling {
    @IBOutlet private weak var scrollView: UIScrollView!

    // MARK: KeyboardFriendlyScrolling

    var keyboardObservers: [NSObjectProtocol] = []
    var keyboardFriendlyScrollView: UIScrollView { return scrollView }

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardFriendlyScrollingObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardFriendlyScrollingObserver()
    }
}

```

<img src="https://user-images.githubusercontent.com/1413408/33512092-0efe68ee-d76c-11e7-848f-b1bd170eb3e7.gif" width="320"/>

## Installation
### Carthage
Cartfile

```
github "morishin/KeyboardFriendlyScrolling"
```

### CocoaPods
Podfile

```ruby
pod 'KeyboardFriendlyScrolling'
```

## LICENSE
MIT
