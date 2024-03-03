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
    var signUpViewModel : SignUpViewModel?
    var isFromLogin: Bool = false
    var customers : [CustomerModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblValidation.isHidden = true
        configureLoadingData()
        //bindToViewModel()
        

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
                    
//                    for item in self.signUpViewModel?.getAllCustomers() {
//                        let comingMail = item.email ?? ""
//                        if comingMail == self?._email{
//                            self?.signUpViewModel?.flag=true
//                        }
//                    }
                    
                    signUpViewModel?.registerCustomer(firstName: _firstName , lastName: _lastName , email: _email, password: _password){ result in
                        
                        print("signUp View controller.registerCustomer")
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
    
    func configureLoadingData(){
        print("configureLoadingData")
        signUpViewModel = SignUpViewModel()
        print("1")
        signUpViewModel?.loadData()
        print("2")
        signUpViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.customers = self?.signUpViewModel?.getAllCustomers() ?? []
                print("customers")
                print(self?.customers?[0].email ?? "")
                guard let customers = self?.signUpViewModel?.getAllCustomers() else {
                    return
                }
                self?.customers = customers
                
                
            }
        }
    }
    
    func bindToViewModel(){
        signUpViewModel?.bindNavigate = { [weak self] in
            DispatchQueue.main.async {
                
                self?.navigate()
            }
        }
        
    }
   
    func navigate(){
        if self.signUpViewModel?.navigate == true{
                if self.isFromLogin == true{
                performSegue(withIdentifier: "toHome", sender: self)
                }else{
                    print("failed")
                }
            }
    }
    
}
