//
//  ChooseImageVC.swift
//  MapAndGallery
//
//  Created by user on 2/24/22.
//

import UIKit
import PhotosUI

class ChooseImageVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePicture(_ sender: Any) {
        
        let imgPicker = UIImagePickerController()
        imgPicker.sourceType = .camera
        imgPicker.delegate = self
        
        self.present(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func selectPicture(_ sender: Any) {
        
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        let provider = results.first?.itemProvider
        
        provider?.loadDataRepresentation(forTypeIdentifier: "public.image", completionHandler: { data, error in
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
            
        })
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
