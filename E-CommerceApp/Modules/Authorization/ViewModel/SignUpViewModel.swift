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
    
    var wishlistDraftId : Int?
    
    var cartDraftId : Int?
    
    var note : String = ""
    
    var navigate: Bool! {
        didSet{
            bindNavigate()
        }
    }
    
    func navigateToHome()-> Bool{
        return navigate
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
    func getAllCustomers()-> [CustomerModel]?{
        return listOfCustomer
    }
    
    func loadData() {
        let apiUrl = APIHandler.urlForGetting(.customers)  //"https://a73c5fc1c095fd186d957dd2093e9006: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@q2-24-team2.myshopify.com/admin/api/2024-01/customers.json?since_id=1"
        print(apiUrl)
        networkHandler?.fetch(url: apiUrl, type: AllCustomers.self, complitionHandler: { data in
            //print("the data from fetching all customers\(data?.customers?.count ?? 0)")
            if let data = data{
                self.listOfCustomer = data.customers
                print("no of customers in load data\(self.listOfCustomer?.count)")
            }else {
                print("error in getting all customers")
                
            }
        }, headers: [
            "Cookie":"",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ])
    }
    
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        model.checkNetworkReachability { isReachable in
            completion(isReachable)
        }
    }
    
    func registerCustomer(firstName: String, lastName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        self.createDraftOrder()
        Thread.sleep(forTimeInterval: 1)
       // self.note = "\(self.cartDraftId ?? 0),\(self.wishlistDraftId ?? 0)"
        if flag == false {
            
            let customer = CustomerModel(
                first_name: firstName,
                last_name: lastName,
                email: email,
                phone: nil,
                tags: password,
                id: nil,
                verified_email: true,
                note: ""
            )
            
            self.registerNewCustomer(customer: customer) { result in
                switch result {
                case true:
                    
                    var customerNote: [String: [String: String]] = [
                        "customer": [
                            "note":"\(self.cartDraftId ?? 0),\(self.wishlistDraftId ?? 0)"
                        ]
                    ]
                    let apiUrl = APIHandler.urlForGetting(.Customer(id: String(self.userDefualt.getCustomerId())))
                    
                    self.networkHandler?.putInApi(url: apiUrl, parameters:customerNote)
//                    //dummy order
//                    let dummyLineItem: [String: Any] = ["title": "dummy", "quantity": 1, "price": "0.0", "properties":[]]
//                    let order = Order(id: 0, lineItems: [LineItem(id: 0, variantID: nil, productID: nil, price: "12.25", name: "45", title: "title", quantity: 1, properties: [])], createdAt: "2024-03-05T14:14:42-05:00", currency: UserDefaults.standard.string(forKey: "currencyTitle") ?? "", currentSubtotalPrice: "", name: "", subtotalPrice: "", totalPrice: "", customer: CustomerModel(first_name: "", last_name: "", email: "", phone: "+13125551212", tags: "", id: self.userDefualt.getCustomerId(), verified_email: false, note: ""), currentTotalDiscounts: "", totalDiscounts: "",appliedDiscount: nil)
//                    let parameters = HelperFunctions().convertToDictionary(object: order, String: "order") ?? [:]
//                    self.networkHandler?.PostToApi(url: APIHandler.urlForGetting(.orders), parameters: parameters)
                    
                    self.navigate = true
                    completion(true)
                    
                case false:
                    self.navigate = false
                    completion(false)
                    
                    
                }
            }
        } else {
            self.navigate = false
            completion(false)
        }
    }
    
    func registerNewCustomer(customer: CustomerModel, completion: @escaping (Bool)->Void ){
        guard let newCustomer = HelperFunctions().convertToDictionary(object: customer, String: "customer") else { return }
        print(newCustomer)
        let apiUrl = APIHandler.urlForGetting(.customers)
        
        
        networkHandler?.postWithResponse(url: apiUrl, type: Customer.self, parameters: newCustomer) {
            customerContainer in
            
            print("calling PostCustomerToAPi")
            
            if let savedCustomer = customerContainer?.customer {
                let id = savedCustomer.id ?? 0
                print("1:\(id)\n")
                
                let customerName = savedCustomer.first_name ?? ""
                print("1:\(customerName)\n")
                
                let customerLastName = savedCustomer.last_name ?? ""
                print("1:\(customerLastName)\n")
                
                let customerEmail = savedCustomer.email ?? ""
                print("1:\(customerEmail)\n")
                
                let customerPassword = savedCustomer.tags ?? ""
                print("1:\(customerPassword)\n")
                
                let customerNote = savedCustomer.note ?? "0"
                print("1:\(customerPassword)\n")
                
                if id != 0 {
                    
                    self.userDefualt.login()
                    self.userDefualt.addCustomerId(id: id)
                    
                    self.userDefualt.addCustomerEmail(customerEmail: customerEmail)
                    self.userDefualt.addCustomerName(customerName: "\(customerName) \(customerLastName)")
                    self.userDefualt.login()
                    self.userDefualt.setUserPassword(password: customerPassword)
                    
                    self.userDefualt.setUserNote(note: "\(self.cartDraftId ?? 0),\(self.wishlistDraftId ?? 0)")
                    print(self.userDefualt.getUserNote())
                    self.userDefualt.setCartID(cartId: String(self.cartDraftId ?? 0))
                    print(self.userDefualt.getCartID())
                    self.userDefualt.setWishlistID(wishlistId: String(self.wishlistDraftId ?? 0))
                    print(self.userDefualt.getWishlistID())
                    print("Password User:\(String(describing: self.userDefualt.getUserPassword()))")
                    print("url:\(apiUrl)")
                    print("put in api : cartId:\(self.cartDraftId ?? 0) wishlist Id :\(self.wishlistDraftId ?? 0)")

                    completion(true)
                    self.navigate = true
                    
                    print("add to userDefualt successfully!!!")
                } else {
                    completion(false)
                    self.navigate = false
                    print("No customer found in the response.")
                }
            }
        }
    }
    
    func createDraftOrder() {
        let dummyLineItem :[String : Any] =
        [
            "title": "dummy",
            "quantity": 1,
            "price": "0.0",
            "properties":[]
        ]
        
        let apiUrl = APIHandler.urlForGetting(.draftOrders)
        networkHandler?.postWithResponse(url: apiUrl, type: DraftOrderContainer.self, parameters: ["draft_order": ["line_items":[dummyLineItem]]], completion: { container in
            
            self.cartDraftId = container?.draftOrder.id
        })
        Thread.sleep(forTimeInterval: 1)
        
        networkHandler?.postWithResponse(url: apiUrl, type: DraftOrderContainer.self, parameters: ["draft_order": ["line_items":[dummyLineItem]]], completion: { container in
            
            self.wishlistDraftId = container?.draftOrder.id
        })
        Thread.sleep(forTimeInterval: 1)
        self.note = "\(self.cartDraftId ?? 0),\(self.wishlistDraftId ?? 0)"

    }
    func addNoteToCustomer( id : Int) {
        
        var customerNote: [String: [String: String]] = [
            "customer": [
                "note":"\(self.cartDraftId ?? 0),\(self.wishlistDraftId ?? 0)"
            ]
        ]
        let apiUrl = APIHandler.urlForGetting(.Customer(id: String(id)))
        print("url:\(apiUrl)")
        print("put in api : cartId:\(self.cartDraftId ?? 0) wishlist Id :\(self.wishlistDraftId ?? 0)")
        networkHandler?.putInApi(url: apiUrl, parameters:customerNote)
        
    }
        
        
    
}
