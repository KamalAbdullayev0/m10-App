//
//  Resources.swift
//  Atl_task
//
//  Created by Kamal Abdullayev on 12.01.25.
//
import Alamofire

class NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseURL = "https://sales-gradle.pashapay.az:443/api/v1"

    var headers: HTTPHeaders {
        var headers: HTTPHeaders = []
        if let token = AuthManager.shared.accessToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }
}
