//
//  LoginViewController.swift
//  Instagram
//
//  Created by Mac on 7/16/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func signUp () {
        // initialize a user object
        let newUser = PFUser()
        
        // set user properties
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        // call sign up function on the object
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
               print("User Sign up successfully")
            } else {
                print(error?.localizedDescription)
                
                }
                // manually segue to logged in view
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        
    }
    
    func loginUser() {
        
        let username = usernameField.text ?? ""
        let password = passwordField.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if error != nil {
                print("User log in failed: \(String(describing: error?.localizedDescription))")
            } else {
                print("User logged in successfully")
                // display view controller that needs to shown after successful login
                
                    // PFUser.current() will now be nil
         self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        signUp()
    }
    
    
    @IBAction func onSignUp(_ sender: Any) {
        loginUser()
    }
    
}
