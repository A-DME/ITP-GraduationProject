//
//  BrandsCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Basma on 22/02/2024.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

   
    
    @IBOutlet weak var brandImg: UIImageView!
    static func nib()->UINib{
        return UINib(nibName: "BrandsCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        brandImg.layer.borderWidth = 2
        brandImg.layer.borderColor = UIColor.black.cgColor
        brandImg.layer.masksToBounds = false
        brandImg.layer.cornerRadius = (brandImg.frame.height)/12
        brandImg.clipsToBounds = true
    }

}
