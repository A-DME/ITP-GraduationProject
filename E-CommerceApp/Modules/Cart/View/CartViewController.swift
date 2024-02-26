//
//  CartViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cartItems: UITableView!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    
    
    @IBOutlet weak var currency: UILabel!
    
    var viewModel: CartViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartItems.delegate = self
        cartItems.dataSource = self
        cartItems.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "cartCell")
        viewModel = CartViewModel()
        subtotalLabel.text = String((viewModel?.totalPrice)!)
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel?.cart.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        cell.productImage.image = UIImage(named: (viewModel?.cart[indexPath.row].img)!)
        cell.productTitle.text = (viewModel?.cart[indexPath.row].name)!
        cell.price.text = "$" + String((viewModel?.cart[indexPath.row].price)!)
        cell.quantity.text = String((viewModel?.cart[indexPath.row].quantity)!)
        if (viewModel?.cart[indexPath.row].quantity)! == 1{
            cell.decreaseButton.isHidden = true
        }
//MARK: Todo: Func. of deleteButton
//        cell.deleteButton.addTarget(cell, action: #selector(self.tableView(_:commit:forRowAt:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
// MARK: Todo: Edit deletion functionality
            let alert = UIAlertController(title: "Confirm Delete", message: "Do you want to delete this product from cart?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: .destructive) { UIAlertAction in
                self.viewModel?.cart.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .left)
                tableView.endUpdates()
            }
            let no = UIAlertAction(title: "No", style: .cancel)
            alert.addAction(yes)
            alert.addAction(no)
            present(alert, animated: true)
        }
    }
    
    @IBAction func purchaseButton(_ sender: Any) {
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
}
