//
//  Resources.swift
//  Atl_task
//
//  Created by Kamal Abdullayev on 12.01.25.
//

import Foundation
import Alamofire

class NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseURL = "https://sales-gradle.pashapay.az:443/api/v1"
    let header: HTTPHeaders = ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNTU3MWRhYTJmYjIzMTljYjQwZjdkMWMxNWNjMGIwNSIsIm5iZiI6MTcyNDM1NTM2OC40OTcsInN1YiI6IjY2Yzc5MzI4NGZhODI1MTAzZGIyZTcyMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-IUzFlm-3iPjHcbFYFKR7mSbFLrAW9YnqDb3-1KPYms"]
}
