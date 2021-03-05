//
// Table.swift
//
// Created by Andreas in 2020
//

import SequenceBuilder
import SwiftUI

public struct Table<Column: ColumnProtocol, Style: TableStyle>: View where Style.Cell == Column.Content, Style.Header == Column.Header {

    let style: Style
    let configuration: TableStyleConfiguration<Style.Header, Style.Cell>

    public init(style: Style, configuration: TableStyleConfiguration<Style.Header, Style.Cell>) {
        self.style = style
        self.configuration = configuration
    }

    public var body: some View {
        style.makeBody(configuration: configuration)
    }
}

extension Table {
    public func tableStyle<S: TableStyle>(style: S) -> some View where S.Cell == Column.Content, S.Header == Column.Header {
        Table<Column, S>(style: style, configuration: configuration)
    }
}

extension Table {
    public init(input: Column.Input, rowCount: Int, @SequenceBuilder builder: () -> [Column]) where Style == DefaultTableStyle<Column.Header, Column.Content> {
        let columns = Array(builder())
        let gridItems = columns.map(\.gridItem)
        self.style = DefaultTableStyle()
        self.configuration = TableStyleConfiguration(
            gridItems: gridItems,
            columns: columns.count,
            rows: rowCount,
            header: { column in columns[column].header },
            cell: { row, column in
                columns[column].view(row: Row(input: input, row: row))
            }
        )
    }

    public init<C: Collection>(collection: C, @SequenceBuilder builder: () -> [Column]) where C == Column.Input, Style == DefaultTableStyle<Column.Header, Column.Content> {
        self.init(input: collection, rowCount: collection.count, builder: builder)
    }
}

struct Table_Previews: PreviewProvider {
    static var previews: some View {
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
    }
}
