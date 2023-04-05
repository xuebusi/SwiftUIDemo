//
//  StackedBarChartView.swift
//  SwiftUIDemo
//
//  Created by shiyanjun on 2023/4/4.
//

import SwiftUI
import Charts

struct StackedBarChartView: View {
    struct ProfitByCategory: Identifiable {
        let id: UUID = UUID()
        let department: String
        let profit: Double
        let productCategory: String
    }
    
    let data: [ProfitByCategory] = [
        ProfitByCategory(department: "Production", profit: 4000, productCategory: "Gizmos"),
        ProfitByCategory(department: "Production", profit: 5000, productCategory: "Gadgets"),
        ProfitByCategory(department: "Production", profit: 6000, productCategory: "Widgets"),
        ProfitByCategory(department: "Marketing", profit: 2000, productCategory: "Gizmos"),
        ProfitByCategory(department: "Marketing", profit: 1000, productCategory: "Gadgets"),
        ProfitByCategory(department: "Marketing", profit: 5000, productCategory: "Widgets"),
        ProfitByCategory(department: "Finance", profit: 2000, productCategory: "Gizmos"),
        ProfitByCategory(department: "Finance", profit: 3000, productCategory: "Gadgets"),
        ProfitByCategory(department: "Finance", profit: 5000, productCategory: "Widgets")
    ]
    
    var body: some View {
        VStack {
            Chart(data) {
                BarMark(
                    x: .value("Category", $0.department),
                    y: .value("Profit", $0.profit)
                )
                .foregroundStyle(by: .value("Product Category", $0.productCategory))
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
    }
}

struct StackedBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        StackedBarChartView()
    }
}

