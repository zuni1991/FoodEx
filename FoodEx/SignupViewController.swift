//
//  SignupViewController.swift
//  FoodEx
//
//  Created by Andrew on 3/16/20.
//  Copyright © 2020 Juan Zuniga. All rights reserved.
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var cityStateField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onSignup(_ sender: Any) {
        let user = PFUser()
        user["name"] = nameField.text
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
        user["location"] = cityStateField.text
        user["zipcode"] = zipcodeField.text
        user["rating"] = 0
        user["numberOfRatings"] = 0
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "ProfilePicSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    

}
