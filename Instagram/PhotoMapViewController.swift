//
//  PhotoMapViewController.swift
//  Instagram
//
//  Created by Mac on 7/18/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse

class PhotoMapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var captionField: UITextField!
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    @IBAction func didTapGesture(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
//     vc.sourceType = UIImagePickerControllerSourceType.camera
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
    // Get the image captured by the UIImagePickerController
    let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
    let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
    
    // Do something with the images (based on your use case)
        photoView.image = editedImage
    // Dismiss UIImagePickerController to go back to your original view controller
    dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createPost(){
        Post.postUserImage(image: photoView.image, withCaption: captionField.text) { (success, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
                else{
                    print("post created")
               self.performSegue(withIdentifier: "loginSegue2", sender: nil)
            }
        }
    }

    @IBAction func onCancel(_ sender: Any) {
         self.performSegue(withIdentifier: "loginSegue2", sender: nil)
    }
    
    @IBAction func onShare(_ sender: Any) {
        createPost()
    }
    
}
