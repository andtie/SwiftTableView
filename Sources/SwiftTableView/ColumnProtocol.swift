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
    associatedtype Footer: View

    var header: Header { get }
    var footer: Footer { get }
    var gridItem: GridItem { get }
    func view(row: Int) -> Content
}

extension Either: ColumnProtocol where Left: ColumnProtocol, Right: ColumnProtocol {
    public var header: Either<Left.Header, Right.Header> {
        bimap(left: \.header, right: \.header)
    }

    public var footer: Either<Left.Footer, Right.Footer> {
        bimap(left: \.footer, right: \.footer)
    }

    public var gridItem: GridItem {
        fold(left: \.gridItem, right: \.gridItem)
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
