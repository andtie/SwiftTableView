//
// Column.swift
//
// Created by Andreas in 2021
//

import SequenceBuilder
import SwiftUI

public struct Column<Input, Header: View, Content: View>: ColumnProtocol {
    public let header: Header
    public let gridItem: GridItem
    private let viewBuilder: (Row<Input>) -> Content

    public func view(row: Row<Input>) -> Content {
        viewBuilder(row)
    }
}

extension Column {
    public init(_ view: @escaping (Row<Input>) -> Content) where Header == Text {
        self.init(header: Text(""), gridItem: GridItem(), viewBuilder: view)
    }

    public func header<H: View>(_ header: H) -> Column<Input, H, Content> {
        Column<Input, H, Content>(header: header, gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func title(_ title: String) -> Column<Input, Text, Content> {
        Column<Input, Text, Content>(header: Text(title), gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func gridItem(_ gridItem: GridItem) -> Self {
        Column(header: header, gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func alignment(_ alignment: Alignment) -> Self {
        let item = GridItem(gridItem.size, spacing: gridItem.spacing, alignment: alignment)
        return Column(header: header, gridItem: item, viewBuilder: viewBuilder)
    }
}
