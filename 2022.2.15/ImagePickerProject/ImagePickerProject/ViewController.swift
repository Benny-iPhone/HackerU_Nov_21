//
//  ViewController.swift
//  ImagePickerProject
//
//  Created by Benny Davidovitz on 15/02/2022.
//

import UIKit
import CoreServices

class ViewController: UIViewController {

    //map our ui options
    enum Option {
        case rearCamera
        case frontCamera
        case gallery
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    //getting called when camera button clicked, suggest the user with 3 options to obtain an image
    @IBAction func takePictureAction(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Select Source", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Rear Camera", style: .default, handler: { _ in
            print("rear camera selected")
            self.showImagePicker(with: .rearCamera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Front Camera", style: .default, handler: { _ in
            print("front camera selected")
            self.showImagePicker(with: .frontCamera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            print("gallery selected")
            self.showImagePicker(with: .gallery)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    //handle user selection, and open UIImagePickerController accordingly
    private func showImagePicker(with option: Option) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //you may specify the desired media types
        //imagePicker.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
        
        switch option {
        case .rearCamera:
            if UIImagePickerController.isSourceTypeAvailable(.camera),
               UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imagePicker.sourceType = .camera
                imagePicker.cameraDevice = .rear
            } else {
                imagePicker.sourceType = .photoLibrary
            }
        case .frontCamera:
            if UIImagePickerController.isSourceTypeAvailable(.camera),
               UIImagePickerController.isCameraDeviceAvailable(.front) {
                imagePicker.sourceType = .camera
                imagePicker.cameraDevice = .front
            } else {
                imagePicker.sourceType = .photoLibrary
            }
        case .gallery:
            imagePicker.sourceType = .photoLibrary
        }
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //handle event of user clicked "cancel" button
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //remove UIImagePickerController from UI
        picker.dismiss(animated: true, completion: nil)
    }
    
    //handle user selected media
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Assuming that we are dealing with image selection (not video)
        //take edited image, if nil - take original image
        let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage
        //imageView.image = image
        
        //remove UIImagePickerController from UI
        //if you wish the user to continue selection, do not close the UI yet
        //picker.dismiss(animated: true, completion: nil)
        
        picker.dismiss(animated: true) {
            self.imageView.image = image
        }
    }
    
}

