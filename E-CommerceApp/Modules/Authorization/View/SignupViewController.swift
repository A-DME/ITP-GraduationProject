//
//  SignupViewController.swift
//  E-CommerceApp
//
//  Created by Menna Setait on 25/02/2024.
//

import UIKit


class SignupViewController: UIViewController {

    @IBOutlet weak var lblValidation: UILabel!
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var secondName: UITextField!
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var passwordConfirmation: UITextField!
    
    var _firstName, _lastName, _email, _password: String!
    let userDefualt = Utilities()
    var signUpViewModel = SignUpViewModel()
    var isFromLogin: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblValidation.isHidden = true
        bindToViewModel()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        _firstName = firstName.text
        _lastName = secondName.text
        _email = emailAddress.text
        _password = password.text
        if _firstName != "" && _lastName != ""{
            if userDefualt.isValidEmail(_email){
                if _password.count >= 6{
                    signUpViewModel.registerCustomer(firstName: _firstName , lastName: _lastName , email: _email, password: _password){ result in
                        print("signUpViewModel.registerCustomer")
                        switch result{
                        case true:
                            print("from view  \(String(describing: self._firstName ?? ""))")
                        case false:
                            DispatchQueue.main.async {
                                self.lblValidation.isHidden = false
                                self.lblValidation.text = "This user already exists"
                            }
                        }
                    }
                }else{
                    lblValidation.isHidden = false
                    lblValidation.text = "Password must be more than 5 digit "
                }
                
            }else{
                lblValidation.isHidden = false
                lblValidation.text = "Please, enter valid email"
            }
        }else{
            lblValidation.isHidden = false
            lblValidation.text = "Required full name "
        }
    }
    
    func bindToViewModel(){
        signUpViewModel.bindNavigate = { [weak self] in
            DispatchQueue.main.async {
                
                self?.navigate()
            }
        }
        
    }
   
    func navigate(){
            if self.signUpViewModel.navigate == true{
                if self.isFromLogin == true{
                performSegue(withIdentifier: "toHome", sender: self)
                }else{
                    print("failed")
                }
            }
    }
    
}
