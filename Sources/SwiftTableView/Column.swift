//
// Column.swift
//
// Created by Andreas in 2021
//

import SequenceBuilder
import SwiftUI

public struct Column<Header: View, Content: View, Footer: View>: ColumnProtocol {
    public let header: Header
    public let footer: Footer
    public let gridItem: GridItem
    private let viewBuilder: (Int) -> Content

    public func view(row: Int) -> Content {
        viewBuilder(row)
    }
}

protocol _DefaultViewProtocol {}

public struct _DefaultView: View, _DefaultViewProtocol {
    public var body: some View {
        Text("")
    }
}

extension Either: _DefaultViewProtocol where Left: _DefaultViewProtocol, Right: _DefaultViewProtocol {}

extension Column {
    public init(@ViewBuilder _ view: @escaping (Int) -> Content) where Header == _DefaultView, Footer == _DefaultView {
        self.init(header: _DefaultView(), footer: _DefaultView(), gridItem: GridItem(), viewBuilder: view)
    }

    public func header<H: View>(@ViewBuilder _ header: () -> H) -> Column<H, Content, Footer> {
        Column<H, Content, Footer>(header: header(), footer: footer, gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func footer<F: View>(@ViewBuilder _ footer: () -> F) -> Column<Header, Content, F> {
        Column<Header, Content, F>(header: header, footer: footer(), gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func title(_ title: String) -> Column<Text, Content, Footer> {
        Column<Text, Content, Footer>(header: Text(title), footer: footer, gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func gridItem(_ gridItem: GridItem) -> Self {
        Column(header: header, footer: footer, gridItem: gridItem, viewBuilder: viewBuilder)
    }

    public func alignment(_ alignment: Alignment) -> Self {
        let item = GridItem(gridItem.size, spacing: gridItem.spacing, alignment: alignment)
        return Column(header: header, footer: footer, gridItem: item, viewBuilder: viewBuilder)
    }
}
