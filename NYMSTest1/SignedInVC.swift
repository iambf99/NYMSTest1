//
//  SignedInVC.swift
//  NYMSTest1
//
//  Created by Brent Fowles on 2019-01-14.
//  Copyright © 2019 Brent Fowles. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignedInVC: UIViewController {

    //outlets
    @IBOutlet weak var emailOu: UITextField!
    
    // variables
    
    //Constants
    let userDefault = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let email = Auth.auth().currentUser?.email else { return }
        emailOu.text = email
        
    }
    

    // actions
    @IBAction func signOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            try GIDSignIn.sharedInstance()?.signOut()
            userDefault.removeObject(forKey: "usersignedin")
            userDefault.synchronize()
            self.dismiss(animated: true, completion: nil)
        } catch let error as NSError {
                print(error.localizedDescription)
            
        }
        
    }
    

}
