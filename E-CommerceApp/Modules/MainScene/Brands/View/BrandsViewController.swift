//
//  BrandsViewController.swift
//  E-CommerceApp
//
//  Created by Basma on 23/02/2024.
//

import UIKit

class BrandsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var ItemsCollection: UICollectionView!
    @IBOutlet weak var brandLogo: UIImageView!
    @IBOutlet weak var itemsCount: UILabel!
    
    var result : Products?
    var sortedProducts : [Product]?
    var indicator : UIActivityIndicatorView?
    var brandsViewModel : BrandsViewModel?
    var vendor : String?
    var brandImage : String?
    var flag :Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIndicator()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        registerCell()
        IntializeProperties()
        self.hideKeyboardWhenTappedAround()
        brandsViewModel = BrandsViewModel()
        brandsViewModel?.checkNetworkReachability{ isReachable in
            if isReachable {
                self.loadData()
            } else {
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
   
    @IBAction func sortList(_ sender: Any) {
        sortedProducts = result?.products.sorted {Double($0.variants.first?.price ?? "0.0") ?? 0.0  < Double($1.variants.first?.price ?? "0.0")  ?? 0.0 }
        flag = !(flag ?? false)
        ItemsCollection.reloadData()
    }
    
    
    
}
// MARK: - UISetup

extension BrandsViewController{
    func IntializeProperties(){
        flag = false
        result = Products(products: [])
    }
    func registerCell(){
        ItemsCollection.register(ItemsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ItemsCell")
    }
    
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.color = .black
        indicator?.center = self.ItemsCollection.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
    }
    func showAlert(){
        let alertController = UIAlertController(title: "No Internet Connection", message: "Check your network and try again", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Retry", style: .cancel) { _ in
            self.viewWillAppear(true)
        }
        
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - getData

extension BrandsViewController{
    
    func loadData(){
        brandsViewModel = BrandsViewModel()
        brandsViewModel?.loadData()
        brandsViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                
                self?.display()
                self?.ItemsCollection.reloadData()
                self?.brandLogo.kf.setImage(with:URL(string: self?.brandImage ?? "placeHolder") ,placeholder: UIImage(named: "placeHolder"))
                self?.itemsCount.text = "\(self?.result?.products.count ?? 0) Items"
            }
        }
    }
    func display() {
        indicator?.stopAnimating()
        result?.products = brandsViewModel?.getAllData(vendor: vendor ?? " ") ?? []
        if (result?.products.count  == 0) {
            ItemsCollection.setEmptyMessage("No Items In Stock ")
        } else {
            ItemsCollection.restore()
        }
        
    }
    
    
}

// MARK: - UICollectionView

extension BrandsViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return result?.products.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ItemsCollection.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: indexPath) as! ItemsCollectionViewCell
        if flag == false{
            let url = URL(string:result?.products[indexPath.row].image.src ?? "")
            cell.productImage.kf.setImage(with:url ,placeholder: UIImage(named: "placeHolder"))
            cell.productTitle.text = (result?.products[indexPath.row].title ?? "").split(separator: "|").dropFirst().first.map(String.init)
            cell.productSubTitle.text = result?.products[indexPath.row].vendor
            cell.productPrice.text = result?.products[indexPath.row].variants.first?.price
        } else {
            let url = URL(string:sortedProducts?[indexPath.row].image.src ?? "")
            cell.productImage.kf.setImage(with:url ,placeholder: UIImage(named: "placeHolder"))
            cell.productTitle.text = (sortedProducts?[indexPath.row].title ?? "").split(separator: "|").dropFirst().first.map(String.init)
            cell.productSubTitle.text = sortedProducts?[indexPath.row].vendor
            cell.productPrice.text = sortedProducts?[indexPath.row].variants.first?.price
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2 - 10
        return CGSize(width: width, height: collectionView.frame.width-60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}

// MARK: - Empty Collection View Handling

extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
