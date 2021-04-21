//
//  DrawView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 19/04/2021.
//

import SwiftUI

struct DrawView: View {
    var image: UIImage?
    var scale: Scale
    
    @State var points: [CGPoint] = []
    @State var lastPoint: CGPoint = .zero
    @State var working: Bool = false
    @State var finished: Bool = false
        
    init(image: UIImage?, scale: Scale) {
        self.image = image
        self.scale = scale
    }
    
    var body: some View {
        VStack{
            ZStack{
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .gesture(DragGesture().onChanged( { value in
                        if !finished {
                            if lastPoint == .zero{
                                lastPoint = value.location
                            }
                            let distance = CGPointDistanceSquared(from: lastPoint, to: value.location)
                            if distance >= 500.0 {
                                lastPoint = value.location
                                self.points.append(lastPoint)
                                working = true
                            }
                            if points.count > 3 {
                                let distanceToClose = CGPointDistanceSquared(from: value.location, to: points[0])
                                if distanceToClose < 100.0 {
                                    working = false
                                    finished = true
                                }
                            }
                        }
                    })
                    .onEnded( { value in
                    }))
                if finished {
                    DrawShape(points: points, finished: finished)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.green)
                        .background(DrawShape(points: points, finished: finished).opacity(0.2).foregroundColor(Color.green))
                }else{
                    DrawShape(points: points, finished: finished)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.green)
                }
                if working || finished {
                    Button(action: {
                        points = []
                        working = false
                        finished = false
                        lastPoint = .zero
                    }) {
                        HStack {
                            Image(systemName: "xmark")
                            Text("Reset")
                        }.padding(5.0)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(Color.green, lineWidth: 2.0)
                        ).background(RoundedRectangle(cornerRadius: 10.0).fill(Color.green))
                    }.position(x: points[0].x-35, y: points[0].y-35)
                }
                ForEach (0..<points.count, id: \.self) { x in
                    Circle()
                        .stroke(Color.green, lineWidth: 1)
                        .frame(width: 6, height: 6)
                        .background(Circle().foregroundColor(finished ? Color.white : Color.green))
                        .position(points[x])
                }
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ScaleView(scale: self.scale)
                            .padding()
                    }
                }
            }.aspectRatio(contentMode: .fit)
            HStack{
                Image(systemName: "scribble")
                    .foregroundColor(iconColor)
                if working {
                    Text("Cierra la ruta para continuar con la medición")
                } else if finished {
                    Text("Toca en Medir para continuar con el proceso")
                }else{
                    Text("Usa tu dedo para rodear el area")
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing: NavigationLink(destination: DrawResultView(image: self.image, points: points, scale: scale)) {
            Text("Siguiente")
        })
    }

    private func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    var iconColor: Color {
        if working {
            return .blue
        } else if finished {
            return .green
        }else{
            return .primary
        }
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView(image: UIImage(named: "arm"), scale: Scale(unit: 1, measureUnit: "cm", scale: [CGPoint(x: 0.0, y: 0.0), CGPoint(x: 5.0, y: 4.0)]))
    }
}
