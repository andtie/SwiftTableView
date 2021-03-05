//
// ColumnProtocol.swift
//
// Created by Andreas in 2021
//

import SequenceBuilder
import SwiftUI

public protocol ColumnProtocol {
    associatedtype Header: View
    associatedtype Content: View

    var header: Header { get }
    var gridItem: GridItem { get }
    func view(row: Int) -> Content
}

extension Either: ColumnProtocol where Left: ColumnProtocol, Right: ColumnProtocol {
    public var header: Either<Left.Header, Right.Header> {
        switch self {
        case let .left(column):
            return .left(column.header)
        case let .right(column):
            return .right(column.header)
        }
    }

    public var gridItem: GridItem {
        switch self {
        case let .left(column):
            return column.gridItem
        case let .right(column):
            return column.gridItem
        }
    }

    @ViewBuilder public func view(row: Int) -> some View {
        switch self {
        case let .left(column):
            column.view(row: row)
        case let .right(column):
            column.view(row: row)
        }
    }
}
