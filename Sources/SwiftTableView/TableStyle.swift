//
// TableStyle.swift
//
// Created by Andreas in 2021
//

import SwiftUI

public protocol TableStyle {
    /// A view that represents the body of a table.
    associatedtype Body: View

    /// A view that represents the header of a table column.
    associatedtype Header: View

    /// A view that represents the footer of a table column.
    associatedtype Footer: View

    /// A view that represents the cell of a table.
    associatedtype Cell: View

    /// The properties of a table.
    typealias Configuration = TableStyleConfiguration<Header, Cell, Footer>

    /// Creates a view that represents the body of a table.
    func makeBody(configuration: Configuration) -> Body
}

public struct TableStyleConfiguration<Header: View, Cell: View, Footer: View> {
    public let gridItems: [GridItem]
    public let columns: Int
    public let rows: Int
    let headerBuilder: (Int) -> Header
    let cellBuilder: (Int, Int) -> Cell
    let footerBuilder: (Int) -> Footer

    public func header(column: Int) -> Header {
        headerBuilder(column)
    }

    public func cell(column: Int, row: Int) -> Cell {
        cellBuilder(column, row)
    }

    public func footer(column: Int) -> Footer {
        footerBuilder(column)
    }
}
