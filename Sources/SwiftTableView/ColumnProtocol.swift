//
// ColumnProtocol.swift
//
// Created by Andreas in 2021
//

import SequenceBuilder
import SwiftUI

public protocol ColumnProtocol {
    associatedtype Input
    associatedtype Header: View
    associatedtype Content: View

    var header: Header { get }
    var gridItem: GridItem { get }
    func view(row: Row<Input>) -> Content
}

public struct Row<Input> {
    public let input: Input
    public let row: Int
}

extension Row where Input: Collection, Input.Index == Int {
    public var value: Input.Element {
        input[row]
    }
}

extension Either: ColumnProtocol where Left: ColumnProtocol, Right: ColumnProtocol, Left.Input == Right.Input {
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

    @ViewBuilder public func view(row: Row<Left.Input>) -> some View {
        switch self {
        case let .left(column):
            column.view(row: row)
        case let .right(column):
            column.view(row: row)
        }
    }
}
