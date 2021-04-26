//
//  LineChartSwiftUI.swift
//  Zauri
//
//  Created by Oihan Arroyo on 26/04/2021.
//

import Charts
import SwiftUI

struct LineChartSwiftUI: UIViewRepresentable {
    var dates: [Double]
    var areas: [Double]
    var datesDouble = [Double]()
    let label: String = "Area (cm\u{00B2})"

    func makeUIView(context: UIViewRepresentableContext<LineChartSwiftUI>) -> LineChartView {
        let lineChart = LineChartView()
        lineChart.noDataText = "No Data Available"
        lineChart.xAxis.valueFormatter = DateAxisValueFormatter()
        lineChart.xAxis.labelCount = dates.count+2
        lineChart.data = addData()
        return lineChart
    }
    
    func addData() -> LineChartData {
        let dataSets = [getLineChartDataSet()]
        let data = LineChartData(dataSets: dataSets)
        data.setValueFont(.systemFont(ofSize: 10, weight: .light))
        return data
    }

    func updateUIView(_ uiView: LineChartView, context: UIViewRepresentableContext<LineChartSwiftUI>) {

    }

    func getChartDataPoints(dates: [Double], areas: [Double]) -> [ChartDataEntry] {
        var dataPoints: [ChartDataEntry] = []
        for count in (0..<dates.count) {
            dataPoints.append(ChartDataEntry.init(x: dates[count], y: areas[count]))
        }
        return dataPoints
    }

    func getLineChartDataSet() -> LineChartDataSet {
        let dataPoints = getChartDataPoints(dates: self.dates, areas: self.areas)
        let set = LineChartDataSet(entries: dataPoints, label: label)
        set.lineWidth = 2.5
        set.circleRadius = 4
        set.circleHoleRadius = 2
        let color = UIColor(Color.blue)
        set.setColor(color)
        set.setCircleColor(color)
        return set
    }
}

struct GraphSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        LineChartSwiftUI(dates: [638371302, 639922902, 641132502], areas: [2.4, 1.9, 0.7])
            .preferredColorScheme(.dark)
    }
}
