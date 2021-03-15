//
// RotatedTableStyle.swift
//
// Created by Andreas in 2021
//

import SwiftUI

public struct RotatedTableStyle<Header: View, Cell: View, Footer: View>: TableStyle {
    public init() {}

    public func makeBody(configuration: TableStyleConfiguration<Header, Cell, Footer>) -> some View {
        HStack {
            if !configuration.hasEmptyHeaders {
                LazyHGrid(rows: configuration.gridItems) {
                    ForEach(0..<configuration.columns, id: \.self) { column in
                        configuration.header(column: column)
                    }
                }
                .font(.headline)
                Color(UIColor.label).frame(width: 1)
            }
            ScrollView(.horizontal) {
                LazyHGrid(rows: configuration.gridItems, spacing: 8) {
                    ForEach(0..<configuration.rows, id: \.self) { row in
                        ForEach(0..<configuration.columns, id: \.self) { column in
                            configuration.cell(column: column, row: row)
                                .id("\(column)-\(row)")
                        }
                    }
                    if !configuration.hasEmptyFooters {
                        ForEach(0..<configuration.columns, id: \.self) { column in
                            configuration.footer(column: column)
                        }
                    }
                }
            }
        }
    }
}
