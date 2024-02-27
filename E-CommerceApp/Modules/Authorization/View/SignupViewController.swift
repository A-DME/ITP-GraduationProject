//
//  SignupViewController.swift
//  E-CommerceApp
//
//  Created by Menna Setait on 25/02/2024.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var secondName: UITextField!
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var passwordConfirmation: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func registerCustomer(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool)->Void ) {
        
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
    }
}
