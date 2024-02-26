//
//  BrandsCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Basma on 22/02/2024.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

   
    
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var brandImg: UIImageView!
    static func nib()->UINib{
        return UINib(nibName: "BrandsCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vBackground.layer.borderWidth = 2
        vBackground.layer.borderColor = UIColor.black.cgColor
        vBackground.layer.masksToBounds = false
        vBackground.layer.cornerRadius = (vBackground.frame.height)/12
        vBackground.clipsToBounds = true
    }

}
