//
//  DetailsViewController.swift
//  Instagram
//
//  Created by Mac on 7/18/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse



class DetailsViewController: UIViewController {
    
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
     var post : Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("Showing the details of the photo ",post!)
       DetailsPhoto()
    }
        // Do any additional setup after loading the view.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
func DetailsPhoto() {
    if let imageFile : PFFile = post?.media {
        imageFile.getDataInBackground { (data, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
            else {
                self.image2.image = UIImage(data: data!)
            }
        }
    }
    timeLabel.text = post?.caption
    captionLabel.text = Timestamp((post?.createdAt)!)
}

func Timestamp(_ date : Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd, yyyy"
    let result = formatter.string(from: date)
    return result
}
    
    @IBAction func onBack(_ sender: Any) {
         self.performSegue(withIdentifier: "loginSeguePhoto", sender: nil)
       
        
    }
    
}
