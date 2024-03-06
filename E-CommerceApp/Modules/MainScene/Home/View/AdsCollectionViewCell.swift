//
//  CollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Basma on 22/02/2024.
//

import UIKit

class AdsCollectionViewCell: UICollectionViewCell {
    static func nib()->UINib{
        return UINib(nibName: "AdsCollectionViewCell", bundle: nil)
    }
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }

}
