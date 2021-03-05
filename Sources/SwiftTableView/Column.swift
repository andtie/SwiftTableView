//
// Column.swift
//
// Created by Andreas in 2021
//

import SequenceBuilder
import SwiftUI

public struct Column<Header: View, Content: View>: ColumnProtocol {
    public let header: Header
    public let gridItem: GridItem
    private let viewBuilder: (Int) -> Content

    public func view(row: Int) -> Content {
        viewBuilder(row)
    }
}

extension Column {
    public init(_ view: @escaping (Int) -> Content) where Header == Text {
        self.init(header: Text(""), gridItem: GridItem(), viewBuilder: view)
    }

    public func header<H: View>(_ header: H) -> Column<H, Content> {
        Column<H, Content>(header: header, gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func title(_ title: String) -> Column<Text, Content> {
        Column<Text, Content>(header: Text(title), gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func gridItem(_ gridItem: GridItem) -> Self {
        Column(header: header, gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func alignment(_ alignment: Alignment) -> Self {
        let item = GridItem(gridItem.size, spacing: gridItem.spacing, alignment: alignment)
        return Column(header: header, gridItem: item, viewBuilder: viewBuilder)
    }
}
