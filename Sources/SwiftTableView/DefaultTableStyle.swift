//
// DefaultTableStyle.swift
//
// Created by Andreas in 2021
//

import SwiftUI

public struct DefaultTableStyle<Header: View, Cell: View, Footer: View>: TableStyle {
    public init() {}

    public func makeBody(configuration: TableStyleConfiguration<Header, Cell, Footer>) -> some View {
        VStack {
            if !configuration.hasEmptyHeaders {
                LazyVGrid(columns: configuration.gridItems) {
                    ForEach(0..<configuration.columns, id: \.self) { column in
                        configuration.header(column: column)
                    }
                }
                .font(.headline)
                Color(UIColor.label).frame(height: 1)
            }
            ScrollView {
                LazyVGrid(columns: configuration.gridItems, spacing: configuration.spacing ?? 8) {
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
