//
//  MainViewController.swift
//  E-CommerceApp
//
//  Created by Basma on 26/02/2024.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
    var mainViewModel : MainViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
        mainViewModel = MainViewModel()
        mainViewModel?.checkNetworkReachability{ isReachable in
            if isReachable {
                
            } else {
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
    func showAlert(){
        let alertController = UIAlertController(title: "No Internet Connection", message: "Check your network and try again", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Retry", style: .cancel) { _ in
            self.viewWillAppear(true)
        }
        
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
/*func tryA(){
        let url = "https://ea12d3c9a7ec864490ccdbb44084163a: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@q2-23-24-ios-sv-team2.myshopify.com/admin/api/2024-01/price_rules.json"
        

        var headers: HTTPHeaders = [
           "Cookie": ""
        ]
       
        let parameters: Parameters = [
            "price_rule": [
                "id": 1171014352961,
                "value_type": "percentage",
                "value": "-25.0",
                "customer_selection": "all",
                "target_type": "line_item",
                "target_selection": "all",
                "allocation_method": "across",
                "allocation_limit": nil,
                "once_per_customer": false,
                "usage_limit": nil,
                "starts_at": "2024-02-15T03:15:09-05:00",
                "ends_at": "2024-05-01T12:00:00-04:00",
                "created_at": "2024-02-17T09:35:36-05:00",
                "updated_at": "2024-02-17T09:35:36-05:00",
                "entitled_product_ids": [],
                "entitled_variant_ids": [],
                "entitled_collection_ids": [],
                "entitled_country_ids": [],
                "prerequisite_product_ids": [],
                "prerequisite_variant_ids": [],
                "prerequisite_collection_ids": [],
                "customer_segment_prerequisite_ids": [],
                "prerequisite_customer_ids": [],
                "prerequisite_subtotal_range": nil,
                "prerequisite_quantity_range": nil,
                "prerequisite_shipping_price_range": nil,
                "prerequisite_to_entitlement_quantity_ratio": [
                    "prerequisite_quantity": nil,
                    "entitled_quantity": nil
                ],
                "prerequisite_to_entitlement_purchase": [
                    "prerequisite_amount": nil
                ],
                "title": "5%OFF",
                "admin_graphql_api_id": "gid://shopify/PriceRule/1171014352961"
            ]
        ]

        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success:
                    if let data = response.data {
                        print("Success: \(String(data: data, encoding: .utf8) ?? "")")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    
                    if let data = response.data {
                        print("Response Data: \(String(data: data, encoding: .utf8) ?? "")")
                    }
                }
            }
    }
}*/
