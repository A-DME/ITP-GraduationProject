//
//  ItemsCollectionViewCell.swift
//  E-CommerceApp
//
//  Created by Basma on 23/02/2024.
//

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
    static func nib()->UINib{
        return UINib(nibName: "ItemsCollectionViewCell", bundle: nil)
    }
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productSubTitle: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vBackground.layer.cornerRadius = 10
                
                // Add shadow
        vBackground.layer.shadowColor = UIColor.black.cgColor
        vBackground.layer.shadowOpacity = 0.5
        vBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        vBackground.layer.shadowRadius = 4
        productImage.layer.cornerRadius = 10
        vBackground.layer.borderWidth = 1
        vBackground.layer.borderColor = UIColor.black.cgColor
    }

}
