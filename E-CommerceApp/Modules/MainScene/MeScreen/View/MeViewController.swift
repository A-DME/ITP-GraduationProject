//
//  MeViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit
import Kingfisher

class MeViewController: UIViewController{
    
    
    @IBOutlet weak var NotLoggedView: UIView!
    @IBOutlet weak var wishlistCollection: UICollectionView!
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var ordersTable: UITableView!
    
    var result : Orders?
    var wishListResult : [LineItem]?
    var indicator : UIActivityIndicatorView?
    var meViewModel : MeViewModel?
    var customerId : Int?
    var customerName : String?
    var loggedIn : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meViewModel = MeViewModel()
        registerCell()
        
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        IntializeProperties()
        setupLongGestureRecognizerOnCollection()
        meViewModel?.checkNetworkReachability{ isReachable in
            if isReachable {
                if self.loggedIn == true{
                    self.greeting.text = "Welcome \(self.customerName ?? "At StyleHub")"
                    self.NotLoggedView.isHidden = true
                    self.setIndicator()
                    self.loadData()
                    self.loadWishlistData()
                }else{
                    self.NotLoggedView.isHidden = false
                }
                
            } else {
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
    
    @IBAction func navigateToWishlist(_ sender: Any) {
        if let tabBarController = self.tabBarController{
            tabBarController.selectedIndex = 2
        }
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailsSegue"{
            let vc = segue.destination as! OrderDetailsTableViewController
            vc.result = result?.orders[ordersTable.indexPathForSelectedRow!.row]
        }
    }
    
    
}
// MARK: - UI setUp
extension MeViewController{
     func IntializeProperties(){
     result = Orders(orders: [])
     wishListResult = []
     customerId = meViewModel?.getCustomerId()
     customerName = meViewModel?.getCustomerName()
     loggedIn = meViewModel?.isLoggedIn()
     }
    func registerCell(){
        wishlistCollection.register(ItemsCollectionViewCell.nib(), forCellWithReuseIdentifier: "favCell")
        ordersTable.register(OrdersTableViewCell.nib(),forCellReuseIdentifier: "orderCell")
    }
    
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.color = .black
        indicator?.center = self.ordersTable.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
    }
    func showAlert(){
        let alertController = UIAlertController(title: "No Internet Connection", message: "Check your network and try again", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Ok", style: .cancel) { _ in
            self.viewWillAppear(true)
        }
        
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
// MARK: - GetData
extension MeViewController{
    func loadData(){
        meViewModel?.loadData()
        meViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.display()
                self?.ordersTable.reloadData()
                
            }
        }
    }
    
    func loadWishlistData(){
        meViewModel?.loadWishlistData()
        meViewModel?.bindWishlistToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.displayWishlist()
                self?.wishlistCollection.reloadData()
                
            }
            
        }
    }
    func display() {
        indicator?.stopAnimating()
        result?.orders = meViewModel?.getOrderData( customerId: customerId ?? 0) ?? []
        if (result?.orders.count  == 0) {
            ordersTable.setEmptyMessage("No Orders Yet ")
        } else {
            ordersTable.restor()
        }
        
    }
    func displayWishlist() {
        wishListResult = meViewModel?.getWishlistData()
        if (wishListResult  == nil) {
            wishlistCollection.setEmptyMessage("No items in Wish list ")
        } else {
            wishlistCollection.restore()
        }
        
    }
    
}
// MARK: - TableView
extension MeViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        result?.orders.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTable.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath) as! OrdersTableViewCell
        cell.orderNum.text = "Order No\(result?.orders[indexPath.row].id ?? 0 )"
        cell.totalAmount.text = "\(result?.orders[indexPath.row].totalPrice ?? "")\(result?.orders[indexPath.row].currency ?? "")"
        cell.CreatedDate.text = result?.orders[indexPath.row].createdAt.split(separator: "T").first.map(String.init)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsSegue", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (ordersTable.frame.height/2)
    }
}
// MARK: - CollectionView
extension MeViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        min(4, wishListResult?.count ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishlistCollection.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! ItemsCollectionViewCell
        let factor = UserDefaults.standard.value(forKey: "factor")as! Double
        cell.productImage.kf.setImage(with:URL(string: (wishListResult?[indexPath.row].properties[0].value)!) ,placeholder: UIImage(named: "placeHolder"))
        cell.productTitle.text = wishListResult?[indexPath.row].name
        cell.productSubTitle.text = " "
        let price = Double(wishListResult?[indexPath.row].price ?? "0.0")
        cell.productPrice.text = String(format: "%.2f" ,factor * (price ?? 0.0))
    
        cell.currency.text = UserDefaults.standard.string(forKey: "currencyTitle")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = wishlistCollection.frame.width / 2 - 20
        return CGSize(width: width, height: wishlistCollection.frame.height)
    }
    
    
}
extension MeViewController: UIGestureRecognizerDelegate{
    func setupLongGestureRecognizerOnCollection() {
       let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
       longPressedGesture.minimumPressDuration = 0.5
       longPressedGesture.delegate = self
       longPressedGesture.delaysTouchesBegan = true
       wishlistCollection?.addGestureRecognizer(longPressedGesture)
      }
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
         return
        }

        let p = gestureRecognizer.location(in:wishlistCollection)

        if let indexPath = wishlistCollection?.indexPathForItem(at: p) {
         print("Long press at item: \(indexPath.row)")
            showDeleteAlert(index: indexPath)
        }
       }
    func showDeleteAlert(index: IndexPath){
        let alertController = UIAlertController(title: "Delete", message: "Are you sure you Want to delete item from Wishlist", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Delete", style: .default) { _ in
            self.wishListResult?.remove(at: index.row)
            self.meViewModel?.updateWishList(wishList: self.wishListResult)
            Thread.sleep(forTimeInterval:0.5)
            self.viewWillAppear(true)
        }
        let no = UIAlertAction(title: "No", style: .cancel)
        alertController.addAction(no)
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
