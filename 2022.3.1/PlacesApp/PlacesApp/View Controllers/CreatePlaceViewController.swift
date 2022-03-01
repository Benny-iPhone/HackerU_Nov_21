//
//  CreatePlaceViewController.swift
//  PlacesApp
//
//  Created by Benny Davidovitz on 22/02/2022.
//

import UIKit
import CoreLocation

class CreatePlaceViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var detectLocationButton: UIButton!
    let locationManager = LocationManager()
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        //open rear camera if available, if not - open gallery
        let picker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func detectLocationAction(_ sender: Any) {
        
        locationManager.getLocation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
                let alert = UIAlertController(title: "Location Error", message: "Failed to fetch location", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .success(let location):
                self.location = location
            }
        }
        
    }
    
    @IBAction func createPlaceAction(_ sender: Any) {
        guard let name = nameTextField.text, name.count > 5 else {
            return
        }
        
        //write to database
        let coordinate: CLLocationCoordinate2D
        if let location = location {
            coordinate = location.coordinate
        } else {
            coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
        Database.database.createPlace(with: name, image: selectedImageView.image, coordinate: coordinate)
        
        //pop back to main screen
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CreatePlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //close the picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //display the selecte image
        selectedImageView.image = info[.originalImage] as? UIImage
        //close the picker
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
