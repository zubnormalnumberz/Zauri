//
//  ScaleView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 19/04/2021.
//

import SwiftUI

struct ScaleView: View {
    
    var scale: Scale
  
    init(scale: Scale) {
        self.scale = scale
    }
    
    var body: some View {
        VStack{
            Text("\(scale.unit) \(scale.measureUnit)")
            Image(systemName: "ruler")
                .font(.system(size: 40))
        }
        .foregroundColor(.white)
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        .background(Color.blue)
        .clipShape(Capsule())
    }
}

struct ScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleView(scale: Scale(unit: 1, measureUnit: "cm", scale: [CGPoint(x: 0.0, y: 1.0), CGPoint(x: 4.0, y: 10.0)]))
    }
}
