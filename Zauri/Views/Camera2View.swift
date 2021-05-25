//
//  Camera2View.swift
//  Zauri
//
//  Created by Oihan Arroyo on 02/05/2021.
//

import SwiftUI
import AlertToast

struct Camera2View: View {
    
    @ObservedObject var modalState: ModalState
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var woundID: String
    var patientID: String
    var userID: String
        
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                VStack{
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    } else {
                        NoPictureView()
                    }
                }
                Spacer()
                if sourceType == .camera{}
                HStack{
                    Button(action: {
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    }) {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Cámara")
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding()
                    Button(action: {
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
                    }) {
                        HStack {
                            Image(systemName: "photo.fill.on.rectangle.fill")
                            Text("Galería")
                        }
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding()
                }
            }
            .navigationBarTitle("Elegir imágen", displayMode: .inline)
            .navigationBarItems(leading: Button("Cerrar") {
                modalState.isCamera2ViewModalPresented = false
            }, trailing: NavigationLink(
                destination: CaliberView(modalState: self.modalState, image: self.selectedImage, woundID: self.woundID, patientID: self.patientID, userID: self.userID, rootIsActive: .constant(false))
            ) {
                Text("Siguiente")
            }.disabled(selectedImage == nil))
//            .fullScreenCover(isPresented: $modalState.isCaliberViewModalPresented){
//                CaliberView(modalState: self.modalState, image: self.selectedImage, woundID: self.woundID, patientID: self.patientID, userID: self.userID)
//            }
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
        }
    }
}

//struct Camera2View_Previews: PreviewProvider {
//    static var previews: some View {
//        Camera2View(modalState: ModalState(), woundID: "", patientID: "String", userID: "String")
//    }
//}
