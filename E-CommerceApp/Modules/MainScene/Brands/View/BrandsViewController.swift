//
//  BrandsViewController.swift
//  E-CommerceApp
//
//  Created by Basma on 23/02/2024.
//

import UIKit

class BrandsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    

    @IBOutlet weak var ItemsCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ItemsCollection.register(ItemsCollectionViewCell.nib(), forCellWithReuseIdentifier: "ItemsCell")
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = ItemsCollection.dequeueReusableCell(withReuseIdentifier: "ItemsCell", for: indexPath) as! ItemsCollectionViewCell
       return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

            let width = collectionView.frame.width / 3 - 1
            return CGSize(width: width, height: width)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1.0
        }
  
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
     _ = segue.destination as! OrderReviewViewController
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Brands", sender: self)
    }

}
/*
 import UIKit

 class YourCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

     override func viewDidLoad() {
         super.viewDidLoad()

         // Assuming you have already set up your collectionView
         if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
             // Set the scroll direction to horizontal if needed
             flowLayout.scrollDirection = .horizontal
             
             // Adjust the minimumInteritemSpacing to control the space between items
             flowLayout.minimumInteritemSpacing = 10
             
             // Calculate the item size based on the available width and the desired number of items in a row
             let width = (collectionView.frame.width - flowLayout.minimumInteritemSpacing) / 2
             flowLayout.itemSize = CGSize(width: width, height: yourDesiredHeight)
         }
     }

     // Implement UICollectionViewDelegateFlowLayout method to adjust item size dynamically if needed
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = (collectionView.frame.width - 10) / 2
         return CGSize(width: width, height: yourDesiredHeight)
     }

     // Implement other necessary UICollectionViewDataSource methods...
 }
 */
/*
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         let width = collectionView.frame.width / 3 - 1
         return CGSize(width: width, height: width)
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 1.0
     }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 1.0
     }
 */
