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

    init(style: Style, configuration: TableStyleConfiguration<Style.Header, Style.Cell>) {
        self.style = style
        self.configuration = configuration
    }

    public var body: some View {
        style.makeBody(configuration: configuration)
    }
}

extension Table {
    public func tableStyle<S: TableStyle>(_ style: S) -> some View where S.Cell == Column.Content, S.Header == Column.Header {
        Table<Column, S>(style: style, configuration: configuration)
    }
}

extension Table {
    public init(rows: Int, @SequenceBuilder builder: () -> [Column]) where Style == DefaultTableStyle<Column.Header, Column.Content> {
        let columns = Array(builder())
        let gridItems = columns.map(\.gridItem)
        self.style = DefaultTableStyle()
        self.configuration = TableStyleConfiguration(
            gridItems: gridItems,
            columns: columns.count,
            rows: rows,
            headerBuilder: { column in columns[column].header },
            cellBuilder: { column, row in columns[column].view(row: row) }
        )
    }
}

struct Table_Previews: PreviewProvider {

    static let numbers = (0...79).map { $0 + 0x1f600 }

    static var previews: some View {
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
    }
}
