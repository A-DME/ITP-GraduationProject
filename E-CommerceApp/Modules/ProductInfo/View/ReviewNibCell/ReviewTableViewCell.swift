//
//  ReviewTableViewCell.swift
//  E-CommerceApp
//
//  Created by Menna Setait on 24/02/2024.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var customerImage: UIImageView!
    
    @IBOutlet weak var customerName: UILabel!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var CreatedAt: UILabel!
    @IBOutlet weak var feedback: UITextView!
    
    @IBOutlet weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    
        customerImage.layer.masksToBounds = false
        customerImage.layer.cornerRadius = (customerImage.frame.height)/12
        customerImage.clipsToBounds = true
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(){
        
    }
    
}
