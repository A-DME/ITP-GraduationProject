//
//  MainViewModel.swift
//  E-CommerceApp
//
//  Created by Basma on 26/02/2024.
//

import Foundation
class MainViewModel{
  
    let model = ReachabilityManager()

  func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
      model.checkNetworkReachability { isReachable in
          completion(isReachable)
      }
  }
}
