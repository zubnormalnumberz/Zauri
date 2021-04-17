//
//  CameraView.swift
//  Zauri
//
//  Created by Oihan Arroyo on 16/04/2021.
//

import SwiftUI

struct CameraView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
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
                        Image(systemName: "snow")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding()
                    }
                }
                Spacer()
                HStack{
                    Button(action: {
                        self.sourceType = .camera
                        self.isImagePickerDisplay.toggle()
                    }) {
                        HStack {
                                Image(systemName: "camera.fill")
                                Text("Cámara")
                            }
                        //session.signOut()
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
                        //session.signOut()
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
            .navigationBarItems(trailing: NavigationLink(destination: CaliberView(image: self.selectedImage)) {
                Text("Siguiente")
            })
            .sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
