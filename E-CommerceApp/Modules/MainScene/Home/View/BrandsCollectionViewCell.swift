//
//  BrandsCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Basma on 22/02/2024.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var brandName: UILabel!
    @IBOutlet weak var brandImg: UIImageView!
    static func nib()->UINib{
        return UINib(nibName: "BrandsCollectionViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
