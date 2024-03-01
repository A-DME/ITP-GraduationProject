//
//  CartViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var cartItems: UITableView!
    
    @IBOutlet weak var subtotal: UILabel!
    
    @IBOutlet weak var currency: UILabel!
    
    var viewModel: CartViewModel?
    
    var cartProducts: [CartProduct]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cartItems.delegate = self
        cartItems.dataSource = self
        cartItems.register(UINib(nibName: "CartTableViewCell", bundle: nil), forCellReuseIdentifier: "cartCell")
        viewModel = CartViewModel()
        cartProducts = viewModel?.cart
        calculateSubtotal()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell") as! CartTableViewCell
        cell.productImage.image = UIImage(named: (cartProducts?[indexPath.row].img)!)
        cell.productTitle.text = (cartProducts?[indexPath.row].name)!
        cell.price.text = "$" + String((cartProducts?[indexPath.row].price)!)
        cell.availableQuantity.text = String((cartProducts?[indexPath.row].availableQuantity)!)
        cell.orderQuantity.text = String((cartProducts?[indexPath.row].quantity)!)
        if (cartProducts?[indexPath.row].quantity)! == 1{
            cell.decreaseButton.isEnabled = false
            cell.decreaseButton.alpha = 0.25
        }
        if Int(cell.orderQuantity.text!)! == Int(cell.availableQuantity.text!)! {
            cell.increaseButton.isEnabled = false
            cell.increaseButton.alpha = 0.25
        }
        cell.increaseButton.addTarget(self, action: #selector(increaseAction), for: .touchUpInside)
        cell.decreaseButton.addTarget(self, action: #selector(decreaseAction), for: .touchUpInside)
//MARK: Todo: Func. of deleteButton -- Done
        cell.deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
// MARK: Todo: Edit deletion functionality
            deleteAlert(tableView, indexPath: indexPath)
        }
    }
    
    @objc func deleteAction(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: cartItems)
        guard let indexPath = cartItems.indexPathForRow(at: point) else {return}
        deleteAlert(cartItems, indexPath: indexPath)
    }
    @objc func increaseAction(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: cartItems)
        guard let indexPath = cartItems.indexPathForRow(at: point) else {return}
        cartProducts?[indexPath.row].quantity += 1
        calculateSubtotal()
    }
    @objc func decreaseAction(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: cartItems)
        guard let indexPath = cartItems.indexPathForRow(at: point) else {return}
        cartProducts?[indexPath.row].quantity -= 1
        calculateSubtotal()
    }
    
    func deleteAlert(_ tableView: UITableView, indexPath: IndexPath){
        let alert = UIAlertController(title: "Confirm Delete", message: "Do you want to delete this product from cart?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Yes", style: .destructive) { UIAlertAction in
            self.cartProducts?.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
            self.calculateSubtotal()
        }
        let no = UIAlertAction(title: "No", style: .cancel)
        alert.addAction(yes)
        alert.addAction(no)
        present(alert, animated: true)
    }
    
    func calculateSubtotal(){
        var totalPrice = 0.0
        for product in cartProducts ?? []{
            totalPrice += product.price * Double(product.quantity)
        }
        self.subtotal.text = String(totalPrice)
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
