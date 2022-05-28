//
//  PhotoPicker.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/20/22.
//

import SwiftUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var avatar: UIImage
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        //not needed in our case
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(photoPicker: self)
    }

    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        //UIImagePickerControllerDelegate is what fires off when user selects an image
        //UINavigationControllerDelegate necessary so we get a dismiss button
        
        let photoPicker: PhotoPicker
        
        init(photoPicker: PhotoPicker) {
            self.photoPicker = photoPicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.editedImage] as? UIImage {
                guard let data = image.jpegData(compressionQuality: 0.3), let compressedImage = UIImage(data: data) else {
                    //error alert
                    return
                }
                photoPicker.avatar = compressedImage
            } else {
                //error alert
            }
            picker.dismiss(animated: true)
        }
    }
}
