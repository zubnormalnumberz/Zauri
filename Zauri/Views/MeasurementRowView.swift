//
//  MeasurementRowView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 09/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct MeasurementRowView: View {
    
    var measurement: PendingMeasurements
    
    var body: some View {
        VStack {
            WebImage(url: URL(string: measurement.imageURL))
                .resizable()
                .placeholder(
                    Image(systemName: "photo")
                )
                .indicator(.activity)
                .transition(.fade(duration: 0.5))
                .scaledToFit()
            
            HStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text(measurement.getDateFormat())
                            .font(.title3)
                        Text(measurement.getTimeFormat())
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    HStack{
                        Text("\(String(format: "%.2f", measurement.area)) cm")
                            .font(.title)
                       + Text("2")
                            .font(.title)
                            .baselineOffset(6.0)
                    }
                }
                .padding()
            }
        }
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 0)
        )
        //.padding([.top, .horizontal])
    }
}

struct MeasurementRowView_Previews: PreviewProvider {
    static var previews: some View {
        MeasurementRowView(measurement: PendingMeasurements(measurementID: "String", userID: "String", width: 1, height: 1, area: 1, perimeter: 1, imageURL: "String", points: [], treatment: "String", dressingType: 1, creationDate: Date(), treatmentEdit: "String", editDate: Date()))
            .preferredColorScheme(.dark)
    }
}
