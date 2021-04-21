//
//  CaliberView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 16/04/2021.
//

import SwiftUI

struct CaliberView: View {
    var image: UIImage?
    @State private var startPoint: CGPoint = CGPoint(x: 200, y: 100)
    @State private var endPoint: CGPoint = CGPoint(x: 100, y: 100)
    @State var lastScaleValue: CGFloat = 1.0
    
    @Environment(\.presentationMode) var presentationMode
    @State var showingSheet = false
    
    @ObservedObject var caliberViewModel = CaliberViewModel()
        
    @State var translation: CGSize = .zero
    
    @State var magScale: CGFloat = 1
    @State var progressingScale: CGFloat = 1
    
    init(image: UIImage?) {
        self.image = image
    }
    
    var body: some View {
        
        let magnification = MagnificationGesture()
                    .onChanged { progressingScale = $0 }
                    .onEnded { amount in
                        if magScale * amount < 1 {
                            magScale = 1
                            progressingScale = 1
                        } else {
                            magScale *= amount
                            progressingScale = 1
                        }
                    }
        let drag = DragGesture()
            .onChanged { value in self.translation = value.translation }
        
        let magnificationAndRotateGesture = magnification.simultaneously(with: drag)
        
        NavigationView {
            VStack{
                ZStack{
                    Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    Path { (path) in
                        path.move(to: startPoint)
                        path.addLine(to: endPoint)
                    }
                    .strokedPath(StrokeStyle(lineWidth: 3, lineCap: .square, lineJoin: .round))
                    .foregroundColor(.gray)

                    Image(systemName: "location.north.fill")
                        .font(.system(size: 25))
                        .position(CGPoint(x: startPoint.x, y: startPoint.y+10))
                        .foregroundColor(.blue)
                        .gesture(DragGesture()
                                    .onChanged { (value) in
                                        self.startPoint = CGPoint(x: value.location.x, y: value.location.y)
                                    }
                        )

                    Image(systemName: "location.north.fill")
                        .font(.system(size: 25))
                        .position(CGPoint(x: endPoint.x, y: endPoint.y+10))
                        .foregroundColor(.blue)
                            .gesture(DragGesture()
                            .onChanged { (value) in
                              self.endPoint = CGPoint(x: value.location.x, y: value.location.y)
                            })
                    Circle()
                        .background(Circle().foregroundColor(Color.gray))
                        .opacity(0.2)
                            .frame(width: 75, height: 75)
                            .position(endPoint)
                    Circle()
                        .background(Circle().foregroundColor(Color.gray))
                        .opacity(0.2)
                            .frame(width: 75, height: 75)
                            .position(startPoint)
                }
                .aspectRatio(contentMode: .fit)
                .scaleEffect(self.magScale * progressingScale)
                .offset(translation)
                .gesture(magnificationAndRotateGesture)
                VStack{
                    Button(action: {
                        showingSheet.toggle()
                    }) {
                        HStack{
                            Image(systemName: "pencil")
                                .font(.system(size: 40))
                            Text("\(caliberViewModel.unit) \(caliberViewModel.measureUnit)")
                        }
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        .background(Color.blue)
                        .clipShape(Capsule())
                    }.sheet(isPresented: $showingSheet) {
                        ReferenceMeasure(caliberViewModel: self.caliberViewModel)
                    }
                }
                .padding(.top, -30)
                Text("adskhfl")
            }
            .navigationBarTitle(Text("Medida de referencia"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cerrar") {
                presentationMode.wrappedValue.dismiss()
            },trailing: NavigationLink(destination: DrawView(image: self.image, scale: Scale(unit: caliberViewModel.unit, measureUnit: caliberViewModel.measureUnit, scale: [startPoint, endPoint]))) {
                Text("Siguiente")
            })
            
        }
    }
}

struct CaliberView_Previews: PreviewProvider {
    static var previews: some View {
        CaliberView(image: UIImage(named: "arm"))
    }
}
