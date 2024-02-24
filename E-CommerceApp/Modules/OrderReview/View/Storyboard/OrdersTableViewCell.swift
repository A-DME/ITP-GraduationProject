//
//  OrdersTableViewCell.swift
//  E-CommerceApp
//
//  Created by Basma on 24/02/2024.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    static func nib()->UINib{
        return UINib(nibName: "OrdersTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
