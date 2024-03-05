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
    
    var _firstName, _lastName, _email, _password: String!
    let userDefualt = Utilities()
    var signUpViewModel : SignUpViewModel?
    var isFromLogin: Bool = false
    var customers : [CustomerModel]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLoadingData()
        bindToViewModel()
        

        // Do any additional setup after loading the view.
    }
    func bindToViewModel(){
        signUpViewModel?.bindNavigate = { [weak self] in
            DispatchQueue.main.async {
                if ((self?.signUpViewModel?.navigateToHome()) == true){
                    self?.navigate()
                }
                else{
                    let alert = UIAlertController(title: "Not Authorized", message: "An Error Occured", preferredStyle: .alert)
                    let gotIt = UIAlertAction(title: "Try Again", style: .cancel)
                    alert.addAction(gotIt)
                    self?.present(alert, animated: true)
                }
            }
        }
    }
   
    func navigate(){
        if self.signUpViewModel?.navigate == true{
            performSegue(withIdentifier: "toHome", sender: self)
        }else {
            print("failed")
            
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
                if passwordConfirmation.text == _password{
                    if _password.count >= 6{
                        
                        
                        for item in (self.signUpViewModel?.getAllCustomers())! {
                            let comingMail = item.email ?? ""
                            if comingMail == _email{
                                print("matched EMail:\(comingMail)")
                                self.signUpViewModel?.flag=true
                            }
                        }
                        if self.signUpViewModel?.flag == true{
                            let alert = UIAlertController(title: "Warning", message: "This user already exists", preferredStyle: .alert)
                            let gotIt = UIAlertAction(title: "Ok", style: .cancel)
                            let signUp = UIAlertAction(title: "Sign In", style: .default) { UIAlertAction in
                                self.performSegue(withIdentifier: "toSign", sender: nil)
                            }
                            
                            alert.addAction(signUp)
                            alert.addAction(gotIt)
                            self.present(alert, animated: true)
                            
                        }else{
                            
                            
                            signUpViewModel?.registerCustomer(firstName: _firstName , lastName: _lastName , email: _email, password: _password){ result in
                                
                                print("signUp View controller.registerCustomer")
                                switch result{
                                case true:
                                    print("from view  \(String(describing: self._firstName ?? ""))")
                                case false:
                                    DispatchQueue.main.async {
                                        let alert = UIAlertController(title: "Warning", message:"Error in registering" , preferredStyle: .alert)
                                        let gotIt = UIAlertAction(title: "Try Again", style: .cancel)
                                        alert.addAction(gotIt)
                                        self.present(alert, animated: true)
                                    }
                                }
                            }
                        }
                    }else{
                        let alert = UIAlertController(title: "Warning", message:"Password must be more than 5 digit" , preferredStyle: .alert)
                        let gotIt = UIAlertAction(title: "Try Again", style: .cancel)
                        alert.addAction(gotIt)
                        self.present(alert, animated: true)
                    }
                }else{
                    
                    let alert = UIAlertController(title: "Warning", message: "Password Confirmation Doesnt match", preferredStyle: .alert)
                    let gotIt = UIAlertAction(title: "Try Again", style: .cancel)
                    alert.addAction(gotIt)
                    self.present(alert, animated: true)
                   
                }
                
            }else{
                let alert = UIAlertController(title: "Warning", message: "Please, enter valid email", preferredStyle: .alert)
                let gotIt = UIAlertAction(title: "Try Again", style: .cancel)
                alert.addAction(gotIt)
                self.present(alert, animated: true)
                
            }
        }else{
            let alert = UIAlertController(title: "Warning", message: "Required full name", preferredStyle: .alert)
            let gotIt = UIAlertAction(title: "Try Again", style: .cancel)
            alert.addAction(gotIt)
            self.present(alert, animated: true)
            
        }
    }
    
    
    

    
}
