//
//  MeViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class MeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var NotLoggedView: UIView!
    @IBOutlet weak var wishlistCollection: UICollectionView!
    @IBOutlet weak var greeting: UILabel!
    @IBOutlet weak var ordersTable: UITableView!
    
    var result : Orders?
    var indicator : UIActivityIndicatorView?
    var meViewModel : MeViewModel?
    var customerId : Int?
    var customerName : String?
    var loggedIn : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        registerCell()
        meViewModel = MeViewModel()
        IntializeProperties()
        meViewModel?.checkNetworkReachability{ isReachable in
            if isReachable {
                if self.loggedIn == true{
                    self.greeting.text = "Welcome \(self.customerName ?? "At StyleHub")"
                    self.NotLoggedView.isHidden = true
                    self.setIndicator()
                    self.loadData()
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
        customerId = 7440718463221
        customerName = "Basma"
        loggedIn = true
    }
    /* func IntializeProperties(){
     result = Orders(orders: [])
     customerId = meViewModel?.getCustomerId()
     customerName = meViewModel?.getCustomerName()
     loggedIn = meViewModel?.isLoggedIn()
     }*/
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
        meViewModel = MeViewModel()
        meViewModel?.loadData()
        meViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                
                self?.display()
                self?.ordersTable.reloadData()
                
            }
        }
    }
    func display() {
        indicator?.stopAnimating()
        result?.orders = meViewModel?.getAllData( customerId: customerId ?? 0) ?? []
        if (result?.orders.count  == 0) {
            ordersTable.setEmptyMessage("No Orders Yet ")
        } else {
            ordersTable.restor()
        }
        
    }
    
    
}
// MARK: - TableView
extension MeViewController{
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
extension MeViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishlistCollection.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! ItemsCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = wishlistCollection.frame.width / 3 - 1
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}
