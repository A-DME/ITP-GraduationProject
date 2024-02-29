//
//  SignUpViewModel.swift
//  E-CommerceApp
//
//  Created by Menna Setait on 28/02/2024.
//

import Foundation
class SignUpViewModel{
    let userDefualt = Utilities()
    
    let model = ReachabilityManager()
    
    var networkHandler:NetworkManager?
    
    var bindResultToViewController : (()->()) = {}
    
    var customers : [CustomerModel] = []
    
    var flag: Bool = false

    var bindNavigate:(()->()) = {}
    
    var bindDontNavigate:(()->()) = {}
    
    var navigate: Bool! {
        didSet{
            bindNavigate()
        }
    }
    var result : CustomerModel?{
        didSet{
            bindResultToViewController()
        }
    }
    
    init() {
        self.networkHandler = NetworkManager()
    }
    var listOfCustomer : [CustomerModel]?{
        didSet{
            bindResultToViewController()
        }
    }
    func getCustomersArray()-> [CustomerModel]?{
        return listOfCustomer
    }
    func getAllCustomers() {
        let endpoint = APIHandler.EndPoints.customers.order
        let shopURL = APIHandler.storeURL
        let apiKey = APIHandler.apiKey
        let accessToken = APIHandler.accessToken
        let apiUrl = "https://\(apiKey):\(accessToken)@\(shopURL)/admin/api/2024-01/\(endpoint)"
        print(apiUrl)
        networkHandler?.fetch(url: apiUrl, type: AllCustomers.self) { data in
            print("the data from fetching all customers\(data?.customers ?? [])")
            if let data = data{
                print(data.customers ?? [])
                print("data=customers")
                self.listOfCustomer = data.customers ?? []
                print("in view")
            }else {
                print("error in getting all customers")
                
            }
        }
    }
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }
    
    func registerCustomer(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        var flag = false
        print(flag)
        bindResultToViewController = { [weak self] in
            print("load.5")
            self?.customers = self?.getCustomersArray() ?? []
        }
        for item in customers {
            let comingMail = item.email ?? ""
            if comingMail == email {
                flag = true
            }
        }
        
        if flag == false {
            let customer = CustomerModel(
                first_name: firstName,
                last_name: lastName,
                email: email,
                phone: nil,
                tags: password,
                id: nil,
                verified_email: true,
                //addresses: nil,
                note: "0"
            )
            
            let newCustomer = Customer(customer: customer)
         /*   self.registerNewCustomer(customer: newCustomer) { result in
                switch result {
                case true:
                    completion(true)
                    self.navigate = true
                case false:
                    completion(false)
                    self.navigate = false
                }
            }*/
        } else {
            self.navigate = false
            completion(false)
        }
    }
    



/*func registerNewCustomer(customer: Customer, completion: @escaping (Bool)->Void ){
        networkHandler?.registerCustomer(newCustomer: customer) {[weak self] (data, response, error )in
            if error != nil{
                print(error!)
                completion(false)
            }else{
                if let data = data{
                    let json = try! JSONSerialization.jsonObject(with: data, options:
                            .allowFragments) as! Dictionary<String, Any>
                    let savedCustomer = json["customer"] as? Dictionary<String,Any>
                    let id = savedCustomer?["id"] as? Int ?? 0
                    let customerName = savedCustomer?["first_name"] as? String ?? ""
                    let customerLastName = savedCustomer?["last_name"] as? String ?? ""
                    let customerEmail = savedCustomer?["email"] as? String ?? ""
                    let customerPassword = savedCustomer?["tags"] as? String ?? ""
                    let customerNote = savedCustomer?["note"] as? String ?? "0"
                    if id != 0 {
                        self?.userDefualt.login()
                        self?.userDefualt.addCustomerId(id: id)
                        self?.userDefualt.addCustomerEmail(customerEmail: customerEmail)
                        self?.userDefualt.addCustomerName(customerName: "\(customerName) \(customerLastName)")
                        self?.userDefualt.login()
                        self?.userDefualt.setUserPassword(password: customerPassword)
                        self?.userDefualt.setUserNote(note: customerNote)
                        print("passwordUserrrr\( String(describing: self?.userDefualt.getUserPassword()))")
                        completion(true)
                        print("add to userDefualt successfully!!!")
                    }else{
                        completion(false)
                        //self?.navigate = false
                        print("error to register")
                    }
                }
            }
        }
    }*/
    
    
}
