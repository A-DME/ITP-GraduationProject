//
//  SettingsViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var settings: UITableView!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    var viewModel : SettingsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navItem.title = "Settings"
        settings.delegate = self
        settings.dataSource = self
        settings.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "settingCell")
        viewModel = SettingsViewModel()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.settingsList.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") as! SettingsTableViewCell
        cell.settingIcon.image = UIImage(named:(viewModel?.settingsList[indexPath.row])!)
        cell.settingLabel.text = (viewModel?.settingsList[indexPath.row])!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "addresses", sender: nil)
        case 1:
            let currency = self.storyboard?.instantiateViewController(identifier: "currency") as! CurrencyViewController
            present(currency, animated: true)
        case 2:
            let applePay = self.storyboard?.instantiateViewController(identifier: "applePay") as! ApplePayViewController
//            applePay.navItem.title = (viewModel?.settingsList[indexPath.row])!
            present(applePay, animated: true)
        case 3:
            let about = self.storyboard?.instantiateViewController(withIdentifier: "about") as! AboutViewController
            present(about, animated: true)
        default:
            print("No such row exists")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    @IBAction func unwindToSettings(unwindSegue: UIStoryboardSegue){}
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
