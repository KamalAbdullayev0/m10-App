//
//  Resources.swift
//  Atl_task
//
//  Created by Kamal Abdullayev on 12.01.25.
//
import Alamofire
import Foundation
import Network

extension Notification.Name {
    static let noInternetDetected = Notification.Name("noInternetDetected")
}

struct RefreshTokenResponse: Codable {
    let accessToken: String
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    init() {}
    
    func request<T: Codable>(endpoint: Endpoint,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             params: Parameters? = nil,
                             encodingType: EncodingType = .url,
                             completion: @escaping((T?, String?) -> Void)) {
        
        // Дождаться, пока NetworkMonitor определит текущее состояние сети
        NetworkMonitor.shared.waitForInitialStatus { [weak self] in
            guard let self = self else { return }
            
            print("🌐 NetworkMonitor: Проверенное isConnected = \(NetworkMonitor.shared.isConnected)")
            
            guard NetworkMonitor.shared.isConnected else {
                print("🛑 Нет соединения! Отправляем Notification...")
                NotificationCenter.default.post(name: .noInternetDetected, object: nil)
                completion(nil, "Нет соединения с интернетом")
                return
            }
            
            // Выполнение запроса через Alamofire
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
                    print("❌ Ошибка Alamofire: \(error.localizedDescription)")
                    
                    if let afError = error.asAFError, afError.isSessionTaskError {
                        print("⚠️ Alamofire: Потеря интернета! Вызываем делегат...")
                        completion(nil, "Нет соединения с интернетом")
                        return
                    }
                    
                    if let urlError = error.underlyingError as? URLError, urlError.code == .notConnectedToInternet {
                        print("⚠️ URLError: Интернет отсутствует! Вызываем делегат...")
                        completion(nil, "Нет интернета")
                        return
                    }
                    
                    if response.response?.statusCode == 401 {
                        self.refreshToken { success in
                            if success {
                                self.request(endpoint: endpoint,
                                             model: model,
                                             method: method,
                                             params: params,
                                             encodingType: encodingType,
                                             completion: completion)
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
    }
    
    private func refreshToken(completion: @escaping (Bool) -> Void) {
        guard let refreshToken = AuthManager.shared.refreshToken else {
            completion(false)
            return
        }
        
        let params: Parameters = ["refresh_token": refreshToken]
        
        AF.request("\(NetworkHelper.shared.baseURL)auth/refresh-token",
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
