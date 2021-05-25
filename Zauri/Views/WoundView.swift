//
//  WoundView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 16/04/2021.
//

import SwiftUI
import SDWebImageSwiftUI
import AlertToast

struct WoundView: View {
    
    @StateObject private var woundViewModel = WoundViewModel()
    
    let wound: Wound
    let patient: Patient
    
    @State var offset: CGFloat = 0
    @State private var showingActionSheet = false
    @State private var showAlertWrongUserID = false
    @State private var showAlertOutOfTime = false
    @State private var showAlertConfirmDeleteMeasurement = false
    
    @EnvironmentObject var session: UserService
    @ObservedObject var modalState: ModalState
    
    func getUser() {
        session.listen()
        woundViewModel.userId = session.self.session?.userID ?? ""
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if woundViewModel.downloading{
                    ProgressView("Downloading…")
                }else if woundViewModel.measurements.count == 0{
                    NoMeasurementView()
                }else{
                    ZStack {
                        ZStack{
                            VStack{
                                TabView(selection: $woundViewModel.currentIndex) {
                                    ForEach(0..<woundViewModel.measurements.count) { i in
                                        NavigationLink(destination: BigImageView(measurement: woundViewModel.measurements[i])){
                                            GeometryReader{ geometryreader in
                                            ZStack {
                                                WebImage(url: URL(string: woundViewModel.measurements[i].imageURL))
                                                    .resizable()
                                                    .placeholder(Image(systemName: "photo"))
                                                    .indicator(.activity)
                                                    .transition(.fade(duration: 0.5))
                                                    .scaledToFit()
                                                DrawShapeEnd(points: woundViewModel.measurements[i].points_small)
                                                    .stroke(lineWidth: 2)
                                                    .foregroundColor(.green)
                                                VStack{
                                                    HStack {
                                                        Text("\(String(format: "%.2f", woundViewModel.measurements[i].area)) cm") + Text("2")
                                                            .baselineOffset(6.0)
                                                    }.padding(5.0)
                                                    .foregroundColor(.white)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 10.0)
                                                            .stroke(Color.green, lineWidth: 2.0)
                                                    ).background(RoundedRectangle(cornerRadius: 10.0).fill(Color.green))
                                                }.position(x: woundViewModel.measurements[i].points_small[0].x-35, y: woundViewModel.measurements[i].points_small[0].y-25)
                                            }
                                            .tag(i)
                                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                                            .frame(width: geometryreader.size.width, height: geometryreader.size.height)
                                        }
                                        }
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
                                    BottomSheet(index: $woundViewModel.currentIndex, measurements: $woundViewModel.measurements, dates: $woundViewModel.dates, areas: $woundViewModel.areas, wound: .constant(wound))
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
            }
            .navigationBarTitle(Text(patient.getShortName()), displayMode: .inline)
            .navigationBarItems(leading: Button("Cerrar") {
                self.modalState.isWoundViewModalPresented = false
            },trailing: Button("Acciones") {
                self.showingActionSheet = true
            })
            .fullScreenCover(isPresented: $modalState.isCamera2ViewModalPresented){
                Camera2View(modalState: self.modalState, woundID: wound.woundID, patientID: patient.patientID, userID: self.session.self.session?.userID ?? "")
            }
            .alert(isPresented: $showAlertConfirmDeleteMeasurement) {
                Alert(
                    title: Text("¿Estas seguro?"),
                    message: Text("Si eliminas esta medición no podras recuperar los datos"),
                    primaryButton: .destructive(Text("Si")) {
                        woundViewModel.deleteMeasurement()
                    },
                    secondaryButton: .cancel(Text("No"))
                  )
            }
            .toast(isPresenting: $woundViewModel.showDeleteMsgToast, duration: 3) {
                AlertToast(type: .complete(Color.green), title: "La medición se ha borrado correctamente")
            }

        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("¿Que acción desea realizar?"), buttons: [
                .default(Text("Añadir medición")) {
                    self.modalState.isCamera2ViewModalPresented = true
                },
                .default(Text("Editar herida")) {},
                .default(Text("Editar medición")) {},
                .destructive(Text("Eliminar medición")){
                    if woundViewModel.measurements[woundViewModel.currentIndex].userID != self.session.self.session?.userID ?? "" {
                        showAlertWrongUserID = true
                    } else if(woundViewModel.measurements[woundViewModel.currentIndex].calculateDateDifference()) {
                        showAlertOutOfTime = true
                    } else {
                        showAlertConfirmDeleteMeasurement = true
                    }
                },
                .cancel()
            ])
        }

        .alert(isPresented: $showAlertWrongUserID) {
            Alert(title: Text("WRONG USER"), message: Text("jsbd"), dismissButton: .cancel())
        }
        .alert(isPresented: $showAlertOutOfTime) {
            Alert(title: Text("OUT OF TIME"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
        }
        .onAppear(){
            getUser()
            woundViewModel.fetchMeasurementsData(wound: self.wound)
        }
        .onReceive(woundViewModel .viewDismissalModePublisher) { shouldDismiss in
            if shouldDismiss {
                self.modalState.isWoundViewModalPresented = false
            }
        }
    }
}

struct WoundView_Previews: PreviewProvider {
    static var previews: some View {
        WoundView(wound: Wound(woundID: "String", pacientID: "String", createdBy: "String", resolved: true, comment: "String", commentEdited: "String", creationDate: Date(), woundType: 1, bodyPart: 1, measurementQuantity: 0), patient: Patient(patientID: "String", name: "Jose Luis", surname1: "Zubibitarte", surname2: "Bilbao", sex: false, dateBirth: Date(), cic: 1, phone: 1), modalState: ModalState())
            
    }
}
