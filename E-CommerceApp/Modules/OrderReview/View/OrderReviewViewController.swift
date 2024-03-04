//
//  OrderReviewViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit
import Kingfisher

class OrderReviewViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var itemsCollection: UICollectionView!
    
    @IBOutlet weak var subTotal: UILabel!
    
    @IBOutlet weak var discount: UILabel!
    
    @IBOutlet weak var totalPrice: UILabel!
    
    @IBOutlet weak var discountField: UITextField!
    
    @IBOutlet weak var applyDiscountButton: UIButton!
    
    var cartItems: [LineItem]?
    
    var draftId: Int!
    
    var viewModel: OrderReviewViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemsCollection.delegate = self
        itemsCollection.dataSource = self
        itemsCollection.register(ItemsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ItemCell")
        viewModel = OrderReviewViewModel()
        reloadView()
    }
    
    func reloadView(){
        Thread.sleep(forTimeInterval: 0.35)
        viewModel?.loadData(draftId: draftId)
        viewModel?.bindResultToViewController = {
            self.cartItems = self.viewModel?.getFilteredCart()
            self.itemsCollection.reloadData()
            self.calculateLabels()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cartItems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollection.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemsCollectionViewCell
        cell.productTitle.text = String(cartItems?[indexPath.row].name?.split(separator: "|")[1] ?? "")
        cell.productSubTitle.text = "Quantity: \(String((cartItems?[indexPath.row].quantity) ?? 1))"
        cell.currency.text = UserDefaults.standard.string(forKey: "currencyTitle")
        cell.productImage.kf.setImage(with: URL(string: cartItems?[indexPath.row].properties[0].value ?? ""))
        cell.productPrice.text = "\(String(format: "%.2f",(UserDefaults.standard.double(forKey: "factor") * Double(cartItems?[indexPath.row].quantity ?? 1) * (Double(cartItems?[indexPath.row].price ?? "0.0") ?? 0.0))))"
       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = itemsCollection.frame.width / 2 - 20
        return CGSize(width: width, height: (itemsCollection.frame.height)-60)
    }
    
    func calculateLabels(){
        var subtotalPrice = 0.0
        for product in cartItems ?? []{
            subtotalPrice += (UserDefaults.standard.double(forKey: "factor") * (Double(product.price) ?? 0.0)) * Double(product.quantity)
        }
        self.subTotal.text = "\(String(format: "%.2f",subtotalPrice)) \(UserDefaults.standard.string(forKey: "currencyTitle") ?? "USD")"
        let discountValue = 20.0
        self.discount.text = "-\("\(String(discountValue))") \(UserDefaults.standard.string(forKey: "currencyTitle") ?? "USD")"
        self.totalPrice.text = "\(String(format: "%.2f",subtotalPrice - discountValue)) \(UserDefaults.standard.string(forKey: "currencyTitle") ?? "USD")"
    }
    
    @IBAction func applyDiscount(_ sender: Any) {
// MARK: - Todo: applying discount logic
        if applyDiscountButton.titleLabel?.text == "Apply"{
            applyDiscountButton.setTitle("Change", for: .normal)
            discountField.isUserInteractionEnabled = false
            discountField.alpha = 0.5
        } else {
            applyDiscountButton.setTitle("Apply", for: .normal)
            discountField.isUserInteractionEnabled = true
            discountField.alpha = 1.0
        }
        
    }
  
// MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        if segue.identifier == "proceed"{
            let addressBook = segue.destination as! AddressBookViewController
            addressBook.draftId = self.draftId
        }
        // Pass the selected object to the new view controller.
    }
    @IBAction func proceedToAddress(_ sender: Any) {
        performSegue(withIdentifier: "proceed", sender: nil)
    }
}
