//
//  PaymentViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 27/02/2024.
//

import UIKit

class PaymentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var methods: UITableView!
    
    @IBOutlet weak var purchaseButton: UIButton!
    
    var viewModel: PaymentViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        methods.delegate = self
        methods.dataSource = self
        methods.register(UINib(nibName: "PaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "paymentCell")
        purchaseButton.isEnabled = false
        viewModel = PaymentViewModel()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Payment Method"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.paymentMethods.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "paymentCell") as! PaymentTableViewCell
        cell.paymentImage.image = UIImage(named: (viewModel?.paymentMethods[indexPath.row])!)
        cell.paymentTitle.text = (viewModel?.paymentMethods[indexPath.row])!
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PaymentTableViewCell
        cell.selectedState.isHidden = false
        self.purchaseButton.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PaymentTableViewCell
        cell.selectedState.isHidden = true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func purchase(_ sender: Any) {
// MARK: TODO: make sure that the payment is done(case apple pay)
        performSegue(withIdentifier: "orderConfirmed", sender: nil)
    }
}
