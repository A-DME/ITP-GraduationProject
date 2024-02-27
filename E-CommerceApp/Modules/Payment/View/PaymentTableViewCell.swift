//
//  PaymentTableViewCell.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 27/02/2024.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowLayer: ShadowView!
    
    @IBOutlet weak var cellMainView: UIView!
    
    @IBOutlet weak var paymentImage: UIImageView!
    
    @IBOutlet weak var paymentTitle: UILabel!
    
    @IBOutlet weak var selectedState: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellMainView.layer.cornerRadius = 16
        cellMainView.layer.masksToBounds = true
        paymentImage.layer.cornerRadius = 15
        selectedState.isUserInteractionEnabled = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = .white
        // Configure the view for the selected state
    }
    
}
