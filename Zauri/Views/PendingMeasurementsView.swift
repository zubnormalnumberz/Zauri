//
//  PendingMeasurements.swift
//  Zauri
//
//  Created by Oihan Arroyo on 05/04/2021.
//

import SwiftUI
import AlertToast

struct PendingMeasurementsView: View {
    
    @ObservedObject private var pendingMeasurementsViewModel = PendingMeasurementsViewModel()
    @EnvironmentObject var session: UserService
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if pendingMeasurementsViewModel.downloading {
                    ProgressView("Downloading…")
                }else{
                    if pendingMeasurementsViewModel.measurements.count == 0{
                        NoPendingMeasurementsView()
                    }else{
                        List(pendingMeasurementsViewModel.measurements, id: \.measurementID) { measurement in
                            NavigationLink(destination: AsignPatientView(pendingMeasurement: measurement, pendingMeasurementViewModel: pendingMeasurementsViewModel)){
                                MeasurementRowView(measurement: measurement)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Mediciones pendientes")
        }.onAppear(){
            getUser()
            pendingMeasurementsViewModel.getPendingMeasurementsData(userId: session.self.session?.userID ?? "")
        }.toast(isPresenting: $pendingMeasurementsViewModel.asigned, duration: 3){
            
            AlertToast(type: .complete(Color.green), title: "La medición pendiente se ha asignado correctamente")
        }
    }
}

struct PendingMeasurements_Previews: PreviewProvider {
    static var previews: some View {
        PendingMeasurementsView()
    }
}
