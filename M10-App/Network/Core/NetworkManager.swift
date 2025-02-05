//
//  Resources.swift
//  Atl_task
//
//  Created by Kamal Abdullayev on 12.01.25.
//
import Alamofire
import Foundation
import Network

struct RefreshTokenResponse: Codable {
    let accessToken: String
}

class NetworkManager {
//    private let networkMonitor = NetworkMonitor.shared
    private weak var appCoordinator: AppCoordinator?

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func request<T: Codable>(endpoint: Endpoint,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             params: Parameters? = nil,
                             encodingType: EncodingType = .url,
                             completion: @escaping((T?, String?) -> Void)) {
        
//        guard networkMonitor.isConnected else {
//            appCoordinator?.showNoInternetFlow()
//            return
//        }

        AF.request("\(NetworkHelper.shared.baseURL)/\(endpoint.rawValue)",
                   method: method,
                   parameters: params,
                   encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                   headers: NetworkHelper.shared.headers)
        .validate()
        .responseDecodable(of: model.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
                
            case .failure(let error):
                if response.response?.statusCode == 401 {
                    self.refreshToken { success in
                        if success {
                            self.request(endpoint: endpoint, model: model, method: method, params: params, encodingType: encodingType, completion: completion)
                        } else {
                            completion(nil, "Сессия истекла, войдите снова")
                        }
                    }
                } else {
                    completion(nil, error.localizedDescription)
                }
            }
        }
    }

    // Обновление токена
    private func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = AuthManager.shared.refreshToken else {
            completion(false)
            return
        }

        let params: Parameters = ["refresh_token": refreshToken]

        AF.request("\(NetworkHelper.shared.baseURL)/auth/refresh",
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: RefreshTokenResponse.self) { response in
            switch response.result {
            case .success(let data):
                AuthManager.shared.accessToken = data.accessToken
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
