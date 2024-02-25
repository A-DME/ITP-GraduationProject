//
//  CartTableViewCell.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 25/02/2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        productImage.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func increaseQuantity(_ sender: Any) {
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
    }
}
