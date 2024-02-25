//
//  ProductInfoViewController.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import UIKit

class ProductInfoViewController: UIViewController {

    var url:[URL] = []
    var indicator : UIActivityIndicatorView?
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    @IBOutlet weak var reviewsTableView: UITableView!
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIndicator()
        dummy()

        // Do any additional setup after loading the view.
    }
    
    func dummy(){
        let url1 = URL(string: "https://www.pngitem.com/pimgs/m/49-491826_of-course-developing-your-employee-%20engagement-offering-business.png")
        let url2 = URL(string: "https://images.pexels.com/photos/39853/woman-girl-freedom-happy-39853.jpeg?auto=compress&cs=tinysrgb&w=600")
        let url3 = URL(string: "https://www.pngitem.com/pimgs/m/49-491826_of-course-developing-your-employee-%20engagement-offering-business.png")
        let url4 = URL(string: "https://www.pngitem.com/pimgs/m/49-491826_of-course-developing-your-employee-%20engagement-offering-business.png")
        let url5 = URL(string: "https://images.pexels.com/photos/1462011/pexels-photo-1462011.jpeg?auto=compress&cs=tinysrgb&w=600")
        url.append(url1!)
        url.append(url2!)
        url.append(url3!)
        url.append(url4!)
        url.append(url5!)
    }
    //MARK: - Indicator initializing
    func setIndicator(){
        indicator = UIActivityIndicatorView(style: .large)
        indicator?.center = self.view.center
        indicator?.startAnimating()
        self.view.addSubview(indicator!)
    
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        
        if segue.identifier == "showReviews"{
            let destination = storyboard?.instantiateViewController(withIdentifier: "allReviews") as? AllReviewsViewController
            // Pass the selected object to the new view controller.
        }
        
        
        
    }
//prodInfo
//allrReviews
    
    
    //MARK: - Configure the TableView (source,delegate,nib cell)
    func configureReviewsTableView(){
        reviewsTableView.dataSource = self
        reviewsTableView.delegate = self
        reviewsTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
    }
    
}

    // MARK: -
extension ProductInfoViewController: UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myDetCell", for: indexPath) as! ProductPositionsCollectionViewCell
                do{
                    let data = try Data(contentsOf : url[indexPath.row])
                    cell.productPositionImage.image = UIImage(data: data)
                }catch{
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath) as! ReviewTableViewCell
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
