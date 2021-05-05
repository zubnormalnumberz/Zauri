//
//  CaliberView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 16/04/2021.
//

import SwiftUI

struct CaliberView: View {
    
    @ObservedObject var modalState: ModalState
    
    var image: UIImage?
    
    var woundID: String
    var patientID: String
    var userID: String
    
    @State private var startPoint: CGPoint = CGPoint(x: 200, y: 100)
    @State private var endPoint: CGPoint = CGPoint(x: 100, y: 100)
    @State var lastScaleValue: CGFloat = 1.0
    
    @State var showingSheet = false
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var caliberViewModel = CaliberViewModel()
            
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    @State var magScale: CGFloat = 1
    @State var progressingScale: CGFloat = 1
    
    var body: some View {
        
        NavigationView {
            VStack{
                Spacer()
                    .frame(height: 125)
                GeometryReader { reader in
                    ZStack{
                        GeometryReader { geometry in
                            Image(uiImage: image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
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
                                                var xPoint: Double = 0.0
                                                var yPoint: Double = 0.0
                                                value.location.y > geometry.size.height + 50 ? (yPoint = Double(geometry.size.height+50)) : (yPoint = Double(value.location.y))
                                                if value.location.y < -50 {
                                                    yPoint = -50.0
                                                }
                                                
                                                value.location.x > geometry.size.width - 25 ? (xPoint = Double(geometry.size.width)-25) : (xPoint = Double(value.location.x))
                                                if value.location.x < 25 {
                                                    xPoint = 25.0
                                                }
                                                
                                                self.startPoint = CGPoint(x: xPoint, y: yPoint)
                                            }
                                )

                            Image(systemName: "location.north.fill")
                                .font(.system(size: 25))
                                .position(CGPoint(x: endPoint.x, y: endPoint.y+10))
                                .foregroundColor(.blue)
                                    .gesture(DragGesture()
                                                .onChanged { (value) in
                                                    var xPoint: Double = 0.0
                                                    var yPoint: Double = 0.0
                                                    value.location.y > geometry.size.height + 50 ? (yPoint = Double(geometry.size.height+50)) : (yPoint = Double(value.location.y))
                                                    if value.location.y < -50 {
                                                        yPoint = -50.0
                                                    }
                                        
                                                    value.location.x > geometry.size.width - 25 ? (xPoint = Double(geometry.size.width-25)) : (xPoint = Double(value.location.x))
                                                    if value.location.x < 25 {
                                                        xPoint = 25.0
                                                    }
                                                    self.endPoint = CGPoint(x: xPoint, y: yPoint)
                                                }
                                    )
                            
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
                    }
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(self.magScale * progressingScale)
                    .offset(x: self.currentPosition.width, y: self.currentPosition.height)
                    .frame(width: reader.size.width, height: reader.size.height)
//                    .gesture(magnificationAndRotateGesture)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                if magScale > 1 {
                                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                                }
                            }
                            .onEnded { value in
                                if magScale > 1 {
                                    self.currentPosition = CGSize(width: value.translation.width + self.newPosition.width, height: value.translation.height + self.newPosition.height)
                                    self.newPosition = self.currentPosition
                                }
                            })
                    .gesture(
                        MagnificationGesture()
                            .onChanged { progressingScale = $0 }
                            .onEnded { amount in
                                if magScale * amount < 1 {
                                    magScale = 1
                                    progressingScale = 1
                                    currentPosition = .zero
                                    newPosition = .zero
                                } else {
                                    magScale *= amount
                                    progressingScale = 1
                                }
                            })
                }
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
                .padding(.top, 50)
                Text("Coloca los marcadores de modo que la distancia entre ellos coincida con el tamaño del mundo real. Toca en el marcador azul para ajustar el valor o la unidad")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .navigationBarTitle(Text("Medida de referencia"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cerrar") {
                //self.modalState.isCamera2ViewModalPresented = false
                presentationMode.wrappedValue.dismiss()
                self.modalState.isCaliberViewModalPresented = false
            },trailing: NavigationLink(destination: DrawView(modalState: self.modalState, image: self.image, scale: Scale(unit: caliberViewModel.unit, measureUnit: caliberViewModel.measureUnit, scale: [startPoint, endPoint]), woundID: self.woundID, patientID: patientID, userID: userID)) {
                Text("Siguiente")
            })
            
        }
    }
}

//struct CaliberView_Previews: PreviewProvider {
//    static var previews: some View {
//        CaliberView(modalState: ModalState(), image: UIImage(named: "arm"), woundID: "String", patientID: "String", userID: "String")
//    }
//}
