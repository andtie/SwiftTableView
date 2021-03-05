# SwiftTableView

**SwiftTableView** allows you to easily create table views in SwiftUI. It is based on [SequenceBuilder](https://github.com/andtie/SequenceBuilder).

Example:
```swift
let numbers = (0...79).map { $0 + 0x1f600 }

Table(rows: numbers.count) {
    Column { Text(String(format: "%02X", numbers[$0])) }
        .title("Codepoint")
        .alignment(.leading)
    Column { Text(String(numbers[$0])) }
        .header(Image(systemName: "number"))
        .alignment(.center)
    Column { Text(String(Character(UnicodeScalar(numbers[$0])!))) }
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
