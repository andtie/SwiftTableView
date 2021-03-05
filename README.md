# SwiftTableView

**SwiftTableView** allows you to easily create table views in SwiftUI. It is based on [SequenceBuilder](https://github.com/andtie/SequenceBuilder).

Example:
```swift
Table(collection: (0...79).map { $0 + 0x1f600 }) {
    Column { (row: Row<[Int]>) in Text(String(format: "%02X", row.value)) }
        .title("Codepoint")
        .alignment(.leading)
    Column { (row: Row<[Int]>) in Text(String(row.value)) }
        .title("Integer")
        .alignment(.center)
    Column { (row: Row<[Int]>) in Text(String(Character(UnicodeScalar(row.value)!))) }
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
