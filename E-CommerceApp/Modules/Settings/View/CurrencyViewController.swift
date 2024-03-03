//
//  CurrencyViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 23/02/2024.
//

import UIKit

class CurrencyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var currencies: UITableView!
    
    var viewModel: CurrencyViewModel?
    
    var currencyList: [String: Double]?
    
    var currenciesArray: [String]?
    
    var rates: [Double]?
    
    var currenciesNames: [String: String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencies.delegate = self
        currencies.dataSource = self
        viewModel = CurrencyViewModel()
        currencyList = ["USDUSD": 1.0].merging(viewModel?.getCurrencyRates() ?? [:]){ (current, _) in current }
        currenciesArray = (Array(currencyList!.keys) as! [String])
        rates = (Array(currencyList!.values) as! [Double])
        currenciesNames = viewModel?.currenciesNames
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell")!
        cell.textLabel?.text = String(currenciesArray?[indexPath.row].suffix(3) ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setCurrencyAlert = UIAlertController(title: "Confirm currency change", message: "Do you want to change the currency of the app to \(currenciesNames[String(currenciesArray![indexPath.row].suffix(3))] ?? "")?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .cancel) { UIAlertAction in
            
            // MARK: - set application currency in userDefaults
            UserDefaults.standard.setValue(self.rates![indexPath.row], forKey: "factor")
            UserDefaults.standard.setValue(String(self.currenciesArray![indexPath.row].suffix(3)), forKey: "currencyTitle")
            print("\(String(self.currenciesArray![indexPath.row].suffix(3))): \(self.rates![indexPath.row])")
            self.dismiss(animated: true)
        }
        let no = UIAlertAction(title: "No", style: .destructive)
        
        setCurrencyAlert.addAction(yes)
        setCurrencyAlert.addAction(no)
        present(setCurrencyAlert, animated: true)
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
