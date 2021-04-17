//
//  WoundView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 16/04/2021.
//

import SwiftUI

struct CardView: View{
    var body: some View {
        ZStack {
            Color.blue
            VStack{
                Text("asfnsab")
            }
        }
    }
}

struct WoundView: View {
    
    @State private var offset = CGSize(width: 0, height: UIScreen.main.bounds.height*0.75)
    
    var body: some View {
        NavigationView {
            VStack{
                Text("SwiftUI tutorials")
                CardView()
                    .offset(self.offset)
                    .animation(.spring())
                    .gesture(DragGesture()
                    .onChanged { gesture in
                        self.offset.height = gesture.translation.height
                    })
            }
            .navigationBarTitle("Patient name", displayMode: .inline)
        }
    }
}

struct WoundView_Previews: PreviewProvider {
    static var previews: some View {
        WoundView()
    }
}
