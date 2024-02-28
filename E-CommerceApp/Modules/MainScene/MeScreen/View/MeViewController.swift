//
//  MeViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class MeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource{
    

    @IBOutlet weak var wishlistCollection: UICollectionView!
    @IBOutlet weak var ordersTable: UITableView!
    
    var result : Orders?
    var indicator : UIActivityIndicatorView?
    var meViewModel : MeViewModel?
    var customerId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
       
    }
    override func viewWillAppear(_ animated: Bool) {
        registerCell()
        IntializeProperties()
        meViewModel = MeViewModel()
        meViewModel?.checkNetworkReachability{ isReachable in
            if isReachable {
                self.setIndicator()
                self.loadData()
            } else {
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = wishlistCollection.dequeueReusableCell(withReuseIdentifier: "favCell", for: indexPath) as! ItemsCollectionViewCell
       return cell
    }
    
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "detailsSegue"{
            let vc = segue.destination as! OrderDetailsTableViewController
            vc.result = result?.orders[ordersTable.indexPathForSelectedRow!.row]
        }
    }
    
    @IBAction func navigateToWishlist(_ sender: Any) {
        if let tabBarController = self.tabBarController{
            tabBarController.selectedIndex = 2
        }
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}
extension MeViewController{
    func IntializeProperties(){
        result = Orders(orders: [])
        customerId = 7995440759099
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
