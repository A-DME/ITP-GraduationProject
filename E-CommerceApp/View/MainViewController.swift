//
//  MainViewController.swift
//  E-CommerceApp
//
//  Created by Basma on 26/02/2024.
//

import UIKit


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
