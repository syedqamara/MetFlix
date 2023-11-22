//
//  Internet.swift
//  MetFlix
//
//  Created by Apple on 23/11/2023.
//

import Foundation
import SystemConfiguration

class Internet {
    fileprivate static let shared = Internet()

    private var reachability: SCNetworkReachability?
    private var reachabilityQueue = DispatchQueue(label: "com.yourapp.networkReachability")

    private init() {
        var zeroAddress = sockaddr()
        zeroAddress.sa_len = UInt8(MemoryLayout<sockaddr>.size)
        zeroAddress.sa_family = sa_family_t(AF_INET)

        reachability = SCNetworkReachabilityCreateWithAddress(nil, &zeroAddress)

        if let reachability = reachability {
            SCNetworkReachabilitySetDispatchQueue(reachability, reachabilityQueue)
        }
    }

    deinit {
        if let reachability = reachability {
            SCNetworkReachabilitySetDispatchQueue(reachability, nil)
        }
    }

    private func isNetworkAvailable() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)

        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)

        return isReachable && !needsConnection
    }
    public static var isAvailable: Bool { shared.isNetworkAvailable() }
}
