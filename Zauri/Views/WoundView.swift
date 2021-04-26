//
//  WoundView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 16/04/2021.
//

import SwiftUI

struct WoundView: View {
    
    @State var offset: CGFloat = 0
    @Environment(\.presentationMode) var presentationMode
    @State private var showingActionSheet = false
    @State private var currentIndex = 0
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack {
                    ZStack{
                        VStack{
                            TabView(selection: $currentIndex) {
                                ForEach(0..<30) { i in
                                    ZStack {
                                        Image("arm")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }.tag(i).clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                }
                                .padding(.horizontal, 10)
                            }
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-450)
                            .tabViewStyle(PageTabViewStyle())
                                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                            Spacer()
                        }
                    }
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
                        GeometryReader{ reader in
                            VStack {
                                BottomSheet(index: $currentIndex)
                                    .offset(y: reader.frame(in: .global).height-340)
                                    .offset(y: offset)
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ (value) in
                                                withAnimation{
                                                    if value.startLocation.y > reader.frame(in: .global).midX{
                                                        
                                                        if value.translation.height < 0 && offset > (-reader.frame(in: .global).height + 340){
                                                            offset = value.translation.height
                                                        }
                                                    }
                                                    
                                                    if value.startLocation.y < reader.frame(in: .global).midX{
                                                        
                                                        if value.translation.height > 0 && offset < 0{
                                                            offset = (-reader.frame(in: .global).height + 340) + value.translation.height
                                                        }
                                                    }
                                                }
                                            })
                                            .onEnded({ (value) in
                                                withAnimation{
                                                    if value.startLocation.y > reader.frame(in: .global).midX{
                                                        if -value.translation.height > reader.frame(in: .global).midX{
                                                            offset = (-reader.frame(in: .global).height + 340)
                                                            
                                                            return
                                                        }
                                                        offset = 0
                                                    }
                                                    
                                                    if value.startLocation.y < reader.frame(in: .global).midX{
                                                        
                                                        if value.translation.height < reader.frame(in: .global).midX{
                                                            offset = (-reader.frame(in: .global).height + 340)
                                                            
                                                            return
                                                        }
                                                        offset = 0
                                                        
                                                    }
                                                }
                                            })
                                    )
                            }
                        }
                        .ignoresSafeArea(.all, edges: .bottom)
                    })
                }
            }
            .navigationBarTitle(Text("Patient name"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cerrar") {
                presentationMode.wrappedValue.dismiss()
            },trailing: Button("Action") {
                self.showingActionSheet = true
            })
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                .default(Text("Red")) {},
                .default(Text("Green")) {},
                .default(Text("Blue")) {},
                .cancel()
            ])
        }
    }
}

struct BottomSheet: View {
    
    @Binding var index: Int
    var colors = ["Red", "Green", "Blue", "Yellow", "Orange", "sdgds", "sdg"]
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
                    Text("Quemadura")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .font(.title)
                    HStack{
                        Text("Torax")
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
                                ForEach(0..<colors.count) { i in
                                    Button(action: {
                                        withAnimation(.easeInOut(duration: 0)) {
                                            self.index = i
                                        }
                                    }) {
                                        if self.index == i {
                                            VStack{
                                                Text("25/12/2022")
                                                    .font(.footnote)
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                Text("12:36")
                                                    .font(.footnote)
                                            }
                                            .padding(5.0)
                                                .foregroundColor(.primary)
                                                .background(Color((UIColor.systemBackground)))
                                                .cornerRadius(8)
                                        }else{
                                            VStack{
                                                Text("22/12/2022")
                                                    .font(.footnote)
                                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                Text("12:36")
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
                                                        print(target)
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
                            Text("1,25 cm2")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                        }.frame(maxWidth: .infinity)
                        VStack{
                            Text("Circunferencia")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("2,25 cm")
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
                            Text("1,25 cm2")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                        }.frame(maxWidth: .infinity)
                        VStack{
                            Text("Anchura")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text("1,25 cm2")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.title)
                        }.frame(maxWidth: .infinity)
                    }.padding()
                    VStack{
                        LineChartSwiftUI(dates: [638371302.0, 639922902.0,   641132502.0], areas: [2.4, 1.9, 0.7])
                            .frame(maxWidth: .infinity,
                                   minHeight: 250,
                                   maxHeight: 250)
                    }.padding(.horizontal)
                    VStack {
                        Picker(selection: $infoSelect, label: Text("What is your favorite color?")) {
                            Text("Tratamiento").tag(0)
                            Text("Información").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        if infoSelect == 0 {
                            Text("Tipo de apósito")
                            Text("Tratamiento")
                        }else{
                            Text("Fecha de creación")
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

struct WoundView_Previews: PreviewProvider {
    static var previews: some View {
        WoundView()
            
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
