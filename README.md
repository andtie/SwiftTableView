# SwiftTableView

**SwiftTableView** allows you to easily create table views in SwiftUI. It is based on [SequenceBuilder](https://github.com/andtie/SequenceBuilder).

Example:
```swift
TableView(collection: (0...79).map { $0 + 0x1f600 }) {
    Column { (input: Int) in Text(String(format: "%02X", input)) }
        .title("Codepoint")
        .alignment(.leading)
    Column { (input: Int) in Text(String(input)) }
        .title("Integer")
        .alignment(.center)
    Column { (input: Int) in Text(String(Character(UnicodeScalar(input)!))) }
        .title("Emoji")
        .alignment(.trailing)
}
.padding()
```

## Installation

### Swift Package Manager

In Xcode, select menu `File > Swift Packages > Add Package Dependency...` and enter the repository URL.
```
Repository: "https://github.com/andtie/SwiftTableView"
```
