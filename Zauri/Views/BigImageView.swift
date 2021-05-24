//
//  BigImageView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 24/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct BigImageView: View {
    
    let measurement: WoundMeasurement
    @State private var showDraw = true
    
    var body: some View {
        VStack {
            ZStack{
                WebImage(url: URL(string: measurement.imageURL))
                    .resizable()
                    .placeholder(Image(systemName: "photo"))
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                if showDraw {
                    DrawShapeEnd(points: measurement.points)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.green)
                }
            }.aspectRatio(contentMode: .fit)
        }
        .navigationBarItems(trailing: Button(action: {
            self.showDraw.toggle()
        }) {
            Image(systemName: showDraw ? "eye.slash.fill" : "eye.fill")
        })
    }
}

struct BigImageView_Previews: PreviewProvider {
    static var previews: some View {
        BigImageView(measurement: WoundMeasurement(measurementID: "String", woundID: "String", patientID: "String", userID: "String", width: 2.0, height: 2.0, area: 2.0, perimeter: 2.0, imageURL: "String", points_small: [], points: [], treatment: "String", dressingType: 1, creationDate: Date(), treatmentEdit: "String", editDate: Date()))
    }
}
