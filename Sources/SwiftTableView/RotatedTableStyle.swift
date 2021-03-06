//
// RotatedTableStyle.swift
//
// Created by Andreas in 2021
//

import SwiftUI

public struct RotatedTableStyle<Header: View, Cell: View>: TableStyle {
    public init() {}

    public func makeBody(configuration: TableStyleConfiguration<Header, Cell>) -> some View {
        HStack {
            LazyHGrid(rows: configuration.gridItems) {
                ForEach(0..<configuration.columns) { column in
                    configuration.header(column: column)
                }
            }
            .font(.headline)
            Color(UIColor.label).frame(width: 1)
            ScrollView(.horizontal) {
                LazyHGrid(rows: configuration.gridItems, spacing: 8) {
                    ForEach(0..<configuration.rows) { row in
                        ForEach(0..<configuration.columns) { column in
                            configuration.cell(column: column, row: row)
                                .id("\(column)-\(row)")
                        }
                    }
                }
            }
        }
    }
}
