//
//  ViewController.swift
//  NYMSTest1
//
//  Created by Brent Fowles on 2019-01-14.
//  Copyright © 2019 Brent Fowles. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {
    // Outlets
    @IBOutlet weak var emailOu: UITextField!
    @IBOutlet weak var passwordOu: UITextField!
    
    
    // Variables
    
    
    // Constants
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userDefault.bool(forKey: "usersignedin") {
            performSegue(withIdentifier: "Segue_to_Signin", sender: self)
        }
    }

    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("User Created")
                self.signInUser(email: email, password: password)
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                // Signed In
                print("User Signed In")
                self.userDefault.set(true, forKey: "usersignedin")
                self.userDefault.synchronize()
                self.performSegue(withIdentifier: "Segue_to_Signin", sender: self)
            } else if error?._code == AuthErrorCode.userNotFound.rawValue {
                self.createUser(email: email, password: password)
            } else {
                print(error)
                print(error?.localizedDescription)
                
            }
        }
    }
    
    //Actions
    @IBAction func signInBtnPressed(_ sender: Any) {
        signInUser(email: emailOu.text!, password: passwordOu.text!)
    }


}

