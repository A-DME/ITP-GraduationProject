//
//  CartTableViewCell.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 25/02/2024.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowLayer: ShadowView!
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productTitle: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var quantity: UILabel!
    
    @IBOutlet weak var decreaseButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 16
        cellView.layer.masksToBounds = true
        productImage.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func increaseQuantity(_ sender: Any) {
        quantity.text = String((Int(quantity.text!))! + 1)
        if Int(quantity.text!)! > 1 {
            decreaseButton.isHidden = false
        }
    }
    
    @IBAction func decreaseQuantity(_ sender: Any) {
        quantity.text = String((Int(quantity.text!))! - 1)
        if Int(quantity.text!)! == 1 {
            decreaseButton.isHidden = true
        }
        
    }
    
    @IBAction func deleteCell(_ sender: Any) {
    }
}

// MARK: - A help from the Internet
// reference: https://stackoverflow.com/questions/37645408/uitableviewcell-rounded-corners-and-shadow#:~:text=The%20best%20way%20to%20do,to%20match%20your%20new%20subclass.


class ShadowView: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }

    private func setupShadow() {
        self.layer.cornerRadius = 16
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 8, height: 8)).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
