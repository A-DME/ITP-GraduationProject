//
//  ProductInfoViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit
import Kingfisher

class ProductInfoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   


    
    var url:[URL] = []
    var productId : Int?
    var productInfoViewModel : ProductInfoViewModel?
    var indicator : UIActivityIndicatorView?
    var reviews : Reviews?
    var Allreviews : [Reviews.Review]?
    
    
    @IBOutlet weak var color: UIButton!
    @IBOutlet weak var size: UIButton!
    
   
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewsTableView: UITableView!
    
    @IBOutlet weak var productNameText: UITextView!
    
    @IBOutlet weak var productRateText: UILabel!
    
    @IBOutlet weak var productPriceText: UILabel!
    
    @IBOutlet weak var productCurrencyText: UILabel!
    
    var sizes : [String]?{
        didSet{
            let actionClosure = { (action: UIAction) in
                print(action.title)
            }

            var menuChildren: [UIMenuElement] = []
            for fruit in sizes ?? [] {
                menuChildren.append(UIAction(title: fruit, handler: actionClosure))
            }
            
            size.menu = UIMenu(options: .displayInline, children: menuChildren)
            
        size.showsMenuAsPrimaryAction = true
        size.changesSelectionAsPrimaryAction = true
        }
    }
    var colors: [String]?{
        didSet{
            let actionClosure = { (action: UIAction) in
                print(action.title)
            }

            var menuChildren: [UIMenuElement] = []
            for fruit in colors ?? [] {
                menuChildren.append(UIAction(title: fruit, handler: actionClosure))
            }
            
            color.menu = UIMenu(options: .displayInline, children: menuChildren)
            
        color.showsMenuAsPrimaryAction = true
        color.changesSelectionAsPrimaryAction = true
        }
    }
    
    @IBOutlet weak var descriptionText: UITextView!


    
    @IBAction func viewAllReviews(_ sender: Any) {
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        reviews = Reviews()
        Allreviews = reviews?.getReviews()
        // Do any additional setup after loading the view.
       

            
            
        //color.frame = CGRect(x: 150, y: 200, width: 100, height: 40)
           
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        configureReviewsTableView()
        configureCollectionView()
        configureLoadingData()
       // dropList()
    }
    @IBAction func addToCart(_ sender: Any) {
        
    }
    
    @IBAction func addTowishList(_ sender: Any) {
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /*func dropList() {
        size.menu = UIMenu(options: .displayInline, children: sizeMenu)
        size.showsMenuAsPrimaryAction = true
        size.changesSelectionAsPrimaryAction = true
        
    }*/
    //MARK: - Indicator initializing
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
    }
    
    
    //MARK: - Configure loading data

    func configureLoadingData(){
        productInfoViewModel = ProductInfoViewModel()
        productInfoViewModel?.loadData(productId: self.productId ?? 0 )
        //print("productId\(productId)")
        
        productInfoViewModel?.bindResultToViewController = { [weak self] in
            DispatchQueue.main.async {
                self?.indicator?.stopAnimating()
                self?.productNameText.text = self?.productInfoViewModel?.getProductDetails()?.title ?? ""
                let factor = UserDefaults.standard.value(forKey: "factor")as! Double
                let price = Double(self?.productInfoViewModel?.getProductDetails()?.variants.first?.price ?? "0.0")
                let currency = UserDefaults.standard.value(forKey: "currencyTitle") as! String
                self?.productPriceText.text = String(format: "%.2f" ,factor * (price ?? 0.0))
                self?.productCurrencyText.text = currency
                self?.descriptionText.text = self?.productInfoViewModel?.getProductDetails()?.bodyHTML
                self?.sizes = self?.productInfoViewModel?.getProductDetails()?.options[0].values
                self?.colors = self?.productInfoViewModel?.getProductDetails()?.options[1].values
               /* for size in (self?.productInfoViewModel?.getProductDetails()?.options[0].values) ?? []{
                    /*if size == ((self?.productInfoViewModel?.getProductDetails()?.options[0].values)!).first{
                        self?.sizeMenu.append(UIAction(title: size, state: .on, handler: self!.actionClosure  ))
                    }*/
                    
                    self?.sizeMenu.append(UIAction(title: size, handler: self!.actionClosure  ))
                }*/
                
                
                self?.myCollectionView.reloadData()
            }
        }
    }
    

    //MARK: - Configure the TableView (source,delegate,nib cell)
    func configureReviewsTableView(){
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        
        reviewsTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "reviewCell")
    }
    
    //MARK: - Configure the CollectionView (source,delegate)
    func configureCollectionView(){
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.register(UINib(nibName: "ProductPositionsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myDetCell")
        
        if let layout = myCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        
    }

    
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productInfoViewModel?.getProductDetails()?.images.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myDetCell", for: indexPath) as! ProductPositionsCollectionViewCell
        let url = URL(string:productInfoViewModel?.getProductDetails()?.images[indexPath.row].src ?? "hey")
        cell.productPositions.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = UIScreen.main.bounds.width
        return CGSize(width:widthPerItem, height:myCollectionView.frame.height/3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 9.0, bottom: 10.0, right: 9.0)
    }
    
   /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
   }*/
   
   
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
        cell.customerName.text = Allreviews?[indexPath.row].customerName
        cell.CreatedAt.text = Allreviews?[indexPath.row].createdAt
        cell.rating.text = String(Allreviews?[indexPath.row].rating ?? 5.0)
        cell.feedback.text = Allreviews?[indexPath.row].massage
        cell.customerImage.image = UIImage(named: Allreviews?[indexPath.row].customerImage ?? "PlaceHolder")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}




    //    // MARK: -
    //extension ProductInfoViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    //
    //    func numberOfSections(in collectionView: UICollectionView) -> Int {
    //        return 1
    //    }
    //
    //
    //    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        return productInfoViewModel?.getProductDetails()?.images.count ?? 0
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myDetCell", for: indexPath) as! ProductPositionsCollectionViewCell
    //        let url = URL(string:productInfoViewModel?.getProductDetails()?.images[indexPath.row].src ?? "")
    //        print("this the url \(url)")
    //        cell.productPositions.kf.setImage(with: url)
    //
    //
    //        return cell
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                            layout collectionViewLayout: UICollectionViewLayout,
    //                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        let width=(( UIScreen.main.bounds.size.width))*0.8
    //        let height=(( UIScreen.main.bounds.size.width))*0.8
    //        return CGSize(width: width, height: height)
    //
    //    }
    //
    //}
