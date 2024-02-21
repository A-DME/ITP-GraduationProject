//
//  ReachabilityManager.swift
//  E-CommerceApp
//
//  Created by Ahmed Abu-zeid on 21/02/2024.
//

import Foundation
import Alamofire

class ReachabilityManager {
    func checkNetworkReachability(completion: @escaping (Bool) -> Void) {
        let reachabilityManager = NetworkReachabilityManager()
        completion(reachabilityManager?.isReachable ?? false)
    }
}
