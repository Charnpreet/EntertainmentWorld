//
//  NetworkConnectivity.swift
//  EntainmentWorld
//
//  Created by CHARNPREET SINGH on 29/4/20.
//  Copyright © 2020 CHARNPREET SINGH. All rights reserved.
//

import Foundation
import Network

class NetworkConnectivity {
    static let shared = NetworkConnectivity()
    var monitor: NWPathMonitor!
    
    private init() {
        
    }
    
    func startMonitoring(completionHandler:@escaping(Bool)->Void) {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if (path.status == .satisfied ){
                
                DispatchQueue.main.async {
                    completionHandler(true)
                }
                
            }
            if(path.status == .unsatisfied){
                DispatchQueue.main.async {
                    completionHandler(false)
                }
            }
            if(path.status == .requiresConnection){
                DispatchQueue.main.async {
                    completionHandler(true)
                }
            }
        }
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
    }
}
