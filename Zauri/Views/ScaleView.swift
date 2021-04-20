//
//  ScaleView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 19/04/2021.
//

import SwiftUI

struct ScaleView: View {
    var body: some View {
        VStack{
            Text("0,5cm")
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
        ScaleView()
    }
}
