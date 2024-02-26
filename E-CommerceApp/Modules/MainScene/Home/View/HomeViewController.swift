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
    
    var result : Collections?
    var indicator : UIActivityIndicatorView?
    var homeViewModel : HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupCollectionView()
        registerCells()
        self.hideKeyboardWhenTappedAround()
        
    }
    @IBAction func CartTabbed(_ sender: Any) {
        performSegue(withIdentifier: "CartSegue", sender: self)
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
}
// MARK: - Get Data
extension HomeViewController{
    func display() {
        indicator?.stopAnimating()
        result = homeViewModel?.getData()
    }
    
    func loadData(){
        setIndicator()
        homeViewModel = HomeViewModel()
        homeViewModel?.loadData()
        homeViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                
                self?.display()
                print(self?.result?.smartCollections[0].title ?? "no data")
                self?.brandsCollection.reloadData()
                
            }
        }
    }
    
}
// MARK: - UICollectionView

extension HomeViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == adsCollectionView{
            return 5
        } else{
            return result?.smartCollections.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == adsCollectionView{
            let cell = adsCollectionView.dequeueReusableCell(withReuseIdentifier: "AdCell", for: indexPath) as! AdsCollectionViewCell
            return cell
        } else{
            let cell = brandsCollection.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath) as! BrandsCollectionViewCell
            let url = URL(string:result?.smartCollections[indexPath.row].image.src ?? "")
            cell.brandImg.kf.setImage(with:url ,placeholder: UIImage(named: "ad"))
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
            brandsVC.vendor = result?.smartCollections[indexPath.row].title
            brandsVC.brandImage = result?.smartCollections[indexPath.row].image.src
            navigationController?.pushViewController(brandsVC, animated: true)
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
