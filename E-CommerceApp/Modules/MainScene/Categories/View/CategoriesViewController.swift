//
//  CategoriesViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class CategoriesViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
   
    
    
    @IBOutlet weak var itemsCollection: UICollectionView!
    @IBOutlet weak var subCategorrySeg: UISegmentedControl!
    @IBOutlet weak var categorySeg: UISegmentedControl!
    
    var category : String?
    var subCategory : String?
    var indicator : UIActivityIndicatorView?
    var categoriesViewModel : CategoriesViewModel?
    var filteredResult : [Product]?
   
    override func viewWillAppear(_ animated: Bool) {
        registerCell()
        setupSegmentesControl()
        self.hideKeyboardWhenTappedAround()
        categoriesViewModel = CategoriesViewModel()
        categoriesViewModel?.checkNetworkReachability{ isReachable in
            print(isReachable)
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
   
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
  
   
}
// MARK: - UISetUp

extension CategoriesViewController{
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.color = .black
        indicator?.center = self.itemsCollection.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
        
    }
    func registerCell(){
        itemsCollection.register(ItemsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ItemCell")
    }
    func setupSegmentesControl(){
        categorySeg.addTarget(self, action: #selector(segmentedControlCategoryChanged(_:)), for: .valueChanged)
        subCategorrySeg.addTarget(self, action: #selector(segmentedControlSuCategoryChanged(_:)), for: .valueChanged)
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
// MARK: - UIcollectionView

extension CategoriesViewController{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = itemsCollection.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemsCollectionViewCell
        let url = URL(string:filteredResult?[indexPath.row].image.src ?? "")
        cell.productImage.kf.setImage(with:url ,placeholder: UIImage(named: "Item"))
        cell.productTitle.text = (filteredResult?[indexPath.row].title ?? "").split(separator: "|").dropFirst().first.map(String.init)
        cell.productSubTitle.text = filteredResult?[indexPath.row].vendor
        cell.productPrice.text = filteredResult?[indexPath.row].variants.first?.price
        
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
// MARK: - getData

extension CategoriesViewController{
    func loadData(){
        categoriesViewModel?.loadData()
        categoriesViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                
                self?.filterResults()
                
                
            }
        }
    }
    
    
    @objc func segmentedControlCategoryChanged(_ sender: UISegmentedControl) {
        
        category = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "All"
        filterResults(category: category ?? "All",subCategory: subCategory ?? "All")
    }
    @objc func segmentedControlSuCategoryChanged(_ sender: UISegmentedControl) {
        
        subCategory = sender.titleForSegment(at: sender.selectedSegmentIndex) ?? "All"
        filterResults(category: category ?? "All",subCategory: subCategory ?? "All")
    }
    
    func filterResults(category:String = "All",subCategory: String = "All"){
        indicator?.stopAnimating()
        if category == "Women"{
            filteredResult = categoriesViewModel?.getWomenData()
        }else if category == "Men"{
            filteredResult = categoriesViewModel?.getMenData()
        }else if category == "Kids"{
            filteredResult = categoriesViewModel?.getKidsData()
        }else if category == "All"{
            filteredResult = categoriesViewModel?.getAllData()
        }
        if subCategory != "All"{
            filteredResult = filteredResult?.filter{
                $0.productType.rawValue == subCategory.uppercased()
            } ?? []
        }
        checkIfNoItems()
        itemsCollection.reloadData()
    }
    func checkIfNoItems(){
        if (filteredResult?.count  == 0) {
            itemsCollection.setEmptyMessage("No Items In Stock ")
        } else {
            itemsCollection.restore()
        }
    }
}
