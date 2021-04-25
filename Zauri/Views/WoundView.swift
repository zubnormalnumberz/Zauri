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
                                        Color.black
                                        Text("Row: \(i)").foregroundColor(.white)
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
            .navigationBarTitle(Text("Medida de referencia"), displayMode: .inline)
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
        
    var body: some View{
        VStack{
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 95, height: 5)
                .padding(.top)
                .padding(.bottom, 25)
            ScrollView(.vertical, showsIndicators: false, content: {
                LazyVStack{
                    Text("Quemadura")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .font(.title)
                    Text("Torax")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                        .font(.callout)
                        .foregroundColor(.gray)
                    Picker(selection: $index, label: Text("What is your favorite color?")) {
                                    Text("Red").tag(0)
                                    Text("Green").tag(1)
                                    Text("Blue").tag(2)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }
            })
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
