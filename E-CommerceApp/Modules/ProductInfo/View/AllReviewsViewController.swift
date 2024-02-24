//
//  AllReviewsViewController.swift
//  E-CommerceApp
//
//  Created by Menna Setait on 24/02/2024.
//

import UIKit

class AllReviewsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        if segue.identifier == "addReview"{
            let destination = storyboard?.instantiateViewController(withIdentifier: "addReview") as? AddReviewViewController
            // Pass the selected object to the new view controller.
        }
        
        
        
    }
//prodInfo
//allrReviews
}
