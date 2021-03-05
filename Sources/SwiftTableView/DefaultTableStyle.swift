//
// DefaultTableStyle.swift
//
// Created by Andreas in 2021
//

import SwiftUI

public struct DefaultTableStyle<Header: View, Cell: View>: TableStyle {
    public init() {}

    public func makeBody(configuration: TableStyleConfiguration<Header, Cell>) -> some View {
        VStack {
            LazyVGrid(columns: configuration.gridItems) {
                ForEach(0..<configuration.columns, id: \.self) { column in
                    configuration.header(column: column)
                }
            }
            .font(.headline)
            Color(UIColor.label).frame(height: 1)
            ScrollView {
                LazyVGrid(columns: configuration.gridItems, spacing: 8) {
                    ForEach(0..<configuration.rows, id: \.self) { row in
                        ForEach(0..<configuration.columns, id: \.self) { column in
                            configuration.cell(column: column, row: row)
                        }
                    }
                }
            }
        }
    }
}
