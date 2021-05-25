//
//  CameraView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 16/04/2021.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject var modalState = ModalState()
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @EnvironmentObject var session: UserService
    
    @State var isActive : Bool = false
    
    var woundID: String
    var patientID: String
            
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: CaliberView(modalState: self.modalState, image: self.selectedImage, woundID: self.woundID, patientID: self.patientID, userID: self.session.self.session?.userID ?? "", rootIsActive: self.$isActive), isActive: $isActive) {
                    EmptyView()
                }
                .isDetailLink(false)
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
            .onAppear(){
                getUser()
            }
            .navigationBarTitle("Elegir imágen", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.isActive.toggle()
            }, label: {
                Text("Siguiente")
            })
            .disabled(selectedImage == nil))
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(modalState: ModalState(), woundID: "", patientID: "")
    }
}
