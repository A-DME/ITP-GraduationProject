//
//  AddNewAddressViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 24/02/2024.
//

import UIKit

class AddNewAddressViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var cityField: UITextField!
    
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var addressField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addAddressButton(_ sender: Any) {
        
        dismiss(animated: true)
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
