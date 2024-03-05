//
//  SettingsViewModel.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation

class SettingsViewModel{
    let settingsList = ["Addresses", "Currency", "About Us"]
    var userDefult : Utilities?
    
    init() {
        self.userDefult = Utilities()
    }

    func isLoggedIn()->Bool{
        return userDefult?.isLoggedIn() ?? false
    }
    
    func logUserOut(){
        userDefult?.logout()
    }
}
