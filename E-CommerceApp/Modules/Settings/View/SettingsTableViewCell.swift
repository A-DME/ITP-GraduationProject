//
//  SettingsTableViewCell.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 23/02/2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingIcon: UIImageView!
    
    @IBOutlet weak var settingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
