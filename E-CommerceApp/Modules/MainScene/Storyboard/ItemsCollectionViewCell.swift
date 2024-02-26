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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
