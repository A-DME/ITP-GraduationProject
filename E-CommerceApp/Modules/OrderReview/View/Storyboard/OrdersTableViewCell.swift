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

    @IBOutlet weak var QuantityLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var CreatedDate: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var vBackground: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        vBackground.layer.shadowColor = UIColor.black.cgColor
        vBackground.layer.shadowOpacity = 0.5
        vBackground.layer.shadowOffset = CGSize(width: 0, height: 2)
        vBackground.layer.shadowRadius = 4
        vBackground.layer.cornerRadius = 10
        // Configure the view for the selected state
    }
    
}
