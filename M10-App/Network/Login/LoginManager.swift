//
//  LoginManager.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
import Foundation

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String,
                 completion: @escaping (Result<AuthResponse, Error>) -> Void)
}

final class LoginUseCase: LoginUseCaseProtocol {
    private let networkManager = NetworkManager()
    
    func execute(email: String, password: String, completion: @escaping (Result<AuthResponse, Error>) -> Void) {
        let params: [String: Any] = ["username": email, "password": password]
        
        networkManager.request(endpoint: .login,
                               model: AuthResponse.self,
                               method: .post,
                               params: params,
                               encodingType: .json) { response, error in
            if let error = error {
                let mappedError: Error = LoginError.networkError(error)
                completion(.failure(mappedError))
                return
            }
            if let response = response {
                completion(.success(response))
            } else {
                completion(.failure(LoginError.unknownError))
            }
        }
    }
}
