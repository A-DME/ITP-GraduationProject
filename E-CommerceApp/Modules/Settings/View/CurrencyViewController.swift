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
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = "Currencies"
        currencies.delegate = self
        currencies.dataSource = self
        viewModel = CurrencyViewModel()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.currencyList.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell")!
        cell.textLabel?.text = (viewModel?.currencyList[indexPath.row])!
        return cell
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
