//
//  BottomSheet.swift
//  Zauri
//
//  Created by Oihan Arroyo on 02/05/2021.
//

import SwiftUI

struct BottomSheet: View {
    
    @Binding var index: Int
    @Binding var measurements: [WoundMeasurement]
    @Binding var dates: [Double]
    @Binding var areas: [Double]
    @Binding var wound: Wound
    @State private var scrollTarget: Int?
    @State private var infoSelect = 0
        
    var body: some View{
        VStack{
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 95, height: 5)
                .padding(.top)
                .padding(.bottom, 25)
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack{
                    Text(WoundType(rawValue: wound.woundType)!.string)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .font(.title)
                    HStack{
                        Text(BodyPart(rawValue: wound.bodyPart)!.string)
                        Text(String(self.index)).hidden().onChange(of: self.index, perform: { value in
                            self.scrollTarget = value
                        })
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                    .font(.callout)
                    .foregroundColor(.gray)
                    ScrollView(.horizontal) {
                        ScrollViewReader { proxy in
                            HStack(spacing: 20) {
                                ForEach(0..<measurements.count) { i in
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0)) {
                                            self.index = i
                                        }
                                    }) {
                                        if self.index == i {
                                            VStack{
                                                Text(measurements[i].getDateFormat())
                                                    .font(.footnote)
                                                    .fontWeight(.bold)
                                                Text(measurements[i].getTimeFormat())
                                                    .font(.footnote)
                                            }
                                            .padding(5.0)
                                                .foregroundColor(.primary)
                                                .background(Color((UIColor.systemBackground)))
                                                .cornerRadius(8)
                                        }else{
                                            VStack{
                                                Text(measurements[i].getDateFormat())
                                                    .font(.footnote)
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                Text(measurements[i].getTimeFormat())
                                                    .font(.footnote)
                                            }
                                            .foregroundColor(.primary)
                                            .padding(5.0)
                                        }
                                    }.id(i).padding(7)
                                }
                            }.background(Color.gray.opacity(0.75))
                            .cornerRadius(8)
                            .onChange(of: scrollTarget) { target in
                                                    if let target = target {
                                                        scrollTarget = nil
                                                        withAnimation {
                                                            proxy.scrollTo(target, anchor: .center)
                                                        }
                                                    }
                                                }
                        }
                    }.cornerRadius(8).padding()
                    HStack{
                        VStack{
                            Text("Área")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.gray)
                            HStack{
                                Text("\(String(format: "%.2f", measurements[index].area)) cm")
                                    .font(.title)
                                + Text("2")
                                    .font(.title)
                                    .baselineOffset(6.0)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }.frame(maxWidth: .infinity)
                        VStack{
                            Text("Perimetro")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("\(String(format: "%.2f", measurements[index].perimeter)) cm")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                        }.frame(maxWidth: .infinity)
                    }.padding()
                    HStack{
                        VStack{
                            Text("Longitud")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("1,25 cm")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                        }.frame(maxWidth: .infinity)
                        VStack{
                            Text("Anchura")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("1,25 cm")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                        }.frame(maxWidth: .infinity)
                    }.padding()
                    if measurements.count > 1{
                        VStack{
                            LineChartSwiftUI(dates: dates, areas: areas)
                                .frame(maxWidth: .infinity,
                                       minHeight: 250,
                                       maxHeight: 250)
                        }.padding(.horizontal)
                    }
                    VStack {
                        Picker(selection: $infoSelect, label: Text("What is your favorite color?")) {
                            Text("Tratamiento").tag(0)
                            Text("Información").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        if infoSelect == 0 {
                            HStack{
                                VStack{
                                    Text("Tipo de apósito")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }.frame(maxWidth: .infinity)
                                VStack{
                                    Text(DressingType(rawValue: measurements[index].dressingType)!.string)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }.frame(maxWidth: .infinity)
                            }.padding()
                            Text("Tratamiento: \(measurements[index].treatment)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                        }else{
                            HStack{
                                VStack{
                                    Text("Fecha de creación")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }.frame(maxWidth: .infinity)
                                VStack{
                                    Text(measurements[index].getDateLongFormat())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }.frame(maxWidth: .infinity)
                            }.padding()
                            Text("Creado por: ")
                        }
                    }
                }
            }
        }
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
    }
    
}

struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}


struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheet(index: .constant(1), measurements: .constant([WoundMeasurement(measurementID: "String", woundID: "String", patientID: "String", userID: "String", width: 1, height: 1, area: 1, perimeter: 1, imageURL: "String", points: [], treatment: "String", dressingType: 1, creationDate: Date(), treatmentEdit: "String", editDate: Date())]), dates: .constant([]), areas: .constant([]), wound: .constant(Wound(woundID: "String", pacientID: "String", createdBy: "String", resolved: false, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 1)))
    }
}
