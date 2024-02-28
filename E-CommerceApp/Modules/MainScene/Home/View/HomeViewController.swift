//
//  HomeViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
   
    @IBOutlet weak var adsCollectionView: UICollectionView!
    @IBOutlet weak var brandsCollection: UICollectionView!
    
    var brandsResult : Collections?
    var adsResult : PriceRules?
    var indicator : UIActivityIndicatorView?
    var homeViewModel : HomeViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIndicator()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setupCollectionView()
        self.registerCells()
        self.hideKeyboardWhenTappedAround()
        homeViewModel = HomeViewModel()
        homeViewModel?.checkNetworkReachability{ isReachable in
            print(isReachable)
            if isReachable {
                self.loadData()
                self.adsCollectionView.reloadData()
                self.brandsCollection.reloadData()
            } else {
                DispatchQueue.main.async {
                    self.showConnectionAlert()
                }
            }
        }
    }
    @IBAction func CartTabbed(_ sender: Any) {
        performSegue(withIdentifier: "CartSegue", sender: self)
    }
    @IBAction func unwindToHomeScreen(unwindSegue: UIStoryboardSegue){
        
    }
    
}
// MARK: - UISetUp
extension HomeViewController{
    func registerCells(){
        adsCollectionView.register(AdsCollectionViewCell.nib(), forCellWithReuseIdentifier: "AdCell")
        brandsCollection.register(BrandsCollectionViewCell.nib(), forCellWithReuseIdentifier: "BrandCell")
    }
    func setupCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        brandsCollection.setCollectionViewLayout(layout, animated: true)
        
    }
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.color = .black
        indicator?.center = self.brandsCollection.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
    }
    func showConnectionAlert(){
        let alertController = UIAlertController(title: "No Internet Connection", message: "Check your network and try again", preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Retry", style: .cancel) { _ in
            self.viewWillAppear(true)
        }
        
        alertController.addAction(doneAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func showCoponeAlert(code:String){
        let alertController = UIAlertController(title: "congratulations", message: "click Copy to get your copone", preferredStyle: .alert)
        
        let copyAction = UIAlertAction(title: "Copy", style: .cancel) { _ in
            UIPasteboard.general.string = code
        }
        
        alertController.addAction(copyAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
// MARK: - Get Data
extension HomeViewController{
    func displayBrands() {
        brandsResult = homeViewModel?.getBrandsData()
    }
    func displayAdsData() {
        indicator?.stopAnimating()
        adsResult = homeViewModel?.getAdsData()
    }
    func loadData(){
       
        homeViewModel?.loadBrandCollectionData()
        homeViewModel?.bindBrandsResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.displayBrands()
                self?.brandsCollection.reloadData()
                
            }
            
        }
        homeViewModel?.loadAdsCollectionData()
        homeViewModel?.bindAdsResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.displayAdsData()
                self?.adsCollectionView.reloadData()
                
            }
        }
        
    }
}
// MARK: - UICollectionView

extension HomeViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollectionView{
            return adsResult?.priceRules.count ?? 0
        } else{
            return brandsResult?.smartCollections.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollectionView{
            let cell = adsCollectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as! AdsCollectionViewCell
            cell.img.image = UIImage(named: "Ad\(indexPath.row)")
            return cell
        } else{
            let cell = brandsCollection.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandsCollectionViewCell
            let url = URL(string:brandsResult?.smartCollections[indexPath.row].image.src ?? "placeHolder")
            cell.brandImg.kf.setImage(with:url ,placeholder: UIImage(named: "placeHolder"))
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == adsCollectionView{
            return CGSize(width: (UIScreen.main.bounds.width) - 50, height: (adsCollectionView.frame.height) - 50)
        } else{
            let widthPerItem = brandsCollection.frame.width / 2 - 20
            return CGSize(width:widthPerItem, height:(brandsCollection.frame.height/2.5)-20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == brandsCollection{
            let brandsVC = storyboard?.instantiateViewController(identifier: "BrandsVC")as! BrandsViewController
            brandsVC.vendor = brandsResult?.smartCollections[indexPath.row].title
            brandsVC.brandImage = brandsResult?.smartCollections[indexPath.row].image.src
            navigationController?.pushViewController(brandsVC, animated: true)
        }else{
            showCoponeAlert(code: adsResult?.priceRules[indexPath.row].title ?? "")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 9.0, bottom: 10.0, right: 9.0)
    }
}
// MARK: - KeyBoard Handling

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
