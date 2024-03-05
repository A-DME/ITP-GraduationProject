//
//  WishlistViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class WishlistViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate{

    
    @IBOutlet weak var notLoggedInView: UIView!
    @IBOutlet weak var wishColletionView: UICollectionView!
    
    var wishListResult : [LineItem]?
    var indicator : UIActivityIndicatorView?
    var wishlistViewModel : WishlistViewModel?
    var loggedIn : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
       
        wishlistViewModel = WishlistViewModel()
        IntializeProperties()
        print(loggedIn)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        wishlistViewModel?.checkNetworkReachability{ isReachable in
            if isReachable {
                if self.loggedIn == true{
                    self.notLoggedInView.isHidden = true
                    self.setIndicator()
                    self.loadWishlistData()
                }else{
                    self.notLoggedInView.isHidden = false
                }
                
            } else {
                DispatchQueue.main.async {
                    self.showAlert()
                }
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wishListResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "wish", for: indexPath) as! ItemsCollectionViewCell
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
        
        let width = wishColletionView.frame.width / 2 - 10
        return CGSize(width: width, height: collectionView.frame.width-60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    
    
}
// MARK: - UI setUp
extension WishlistViewController{
     func IntializeProperties(){
     wishListResult = []
     loggedIn = wishlistViewModel?.isLoggedIn()
        
     }
    func configureTableView(){
        wishColletionView.dataSource = self
        wishColletionView.delegate = self
        wishColletionView.register(UINib(nibName: "ItemsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "wish")
    }
    
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.color = .black
        indicator?.center = self.wishColletionView.center
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
extension WishlistViewController{

 func loadWishlistData(){
        wishlistViewModel?.loadWishlistData()
     wishlistViewModel?.bindWishlistToViewController = {[weak self] in
            DispatchQueue.main.async {
                self?.displayWishlist()
                self?.wishColletionView.reloadData()
                
            }
            
        }
    }
    func displayWishlist() {
        indicator?.stopAnimating()
        wishListResult = wishlistViewModel?.getWishlistData()
        if (wishListResult  == nil) {
            wishColletionView.setEmptyMessage("No items in Wish list ")
        } else {
            wishColletionView.restore()
        }
        
    }
    
}
