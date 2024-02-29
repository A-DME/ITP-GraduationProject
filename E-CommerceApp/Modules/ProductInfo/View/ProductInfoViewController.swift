//
//  ProductInfoViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit
import Kingfisher

class ProductInfoViewController: UIViewController {
    
    var url:[URL] = []
    var productId : Int?
    var productInfoViewModel : ProductInfoViewModel?
    var indicator : UIActivityIndicatorView?
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewsTableView: UITableView!
    
    @IBOutlet weak var productNameText: UITextView!
    
    @IBOutlet weak var productRateText: UILabel!
    
    @IBOutlet weak var productPriceText: UILabel!
    
    @IBOutlet weak var productCurrencyText: UILabel!
    
    @IBOutlet weak var size: UISegmentedControl!
    
    @IBOutlet weak var color: UISegmentedControl!
    
    @IBOutlet weak var descriptionText: UITextView!
    
    @IBAction func viewAllReviews(_ sender: Any) {
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureReviewsTableView()
        configureCollectionView()
        
        //configureLoadingData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        configureLoadingData()
    }
    @IBAction func addToCart(_ sender: Any) {
        
    }
    
    @IBAction func addTowishList(_ sender: Any) {
        
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    //MARK: - Indicator initializing
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
    
    }
    
    
    //MARK: - Configure data loading

    func configureLoadingData(){
        productInfoViewModel?.loadData(productId: self.productId!)
        print("productId\(productId)")
        productInfoViewModel?.bindResultToViewController = {
            [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                print(self?.productInfoViewModel?.getProductDetails())
                self?.productNameText.text = (self?.productInfoViewModel?.getProductDetails()?.title ?? "").split(separator: "|").dropFirst().first.map(String.init)
                self?.productPriceText.text = self?.productInfoViewModel?.getProductDetails()?.variants.first?.price
                
                }
        }
        
       

       
    }
    
    
    //MARK: - Configure the TableView (source,delegate,nib cell)
    func configureReviewsTableView(){
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        reviewsTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
    }
    //MARK: - Configure the CollectionView (source,delegate,nib cell)
    func configureCollectionView(){
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
    }
    
    
    // MARK: - Rendering Data
   
}
    // MARK: -
extension ProductInfoViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productInfoViewModel?.getProductDetails()?.images.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myDetCell", for: indexPath) as! ProductPositionsCollectionViewCell
        cell.productPositionImage.kf.setImage(with: URL(string: (productInfoViewModel?.getProductDetails()?.images[indexPath.row].src as! String) ))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width=(( UIScreen.main.bounds.size.width))*0.8
        let height=(( UIScreen.main.bounds.size.width))*0.8
        return CGSize(width: width, height: height)
        
    }
    
}


    // MARK: -
extension ProductInfoViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        //cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
