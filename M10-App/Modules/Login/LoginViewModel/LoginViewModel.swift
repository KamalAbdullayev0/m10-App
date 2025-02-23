//
//  LoginViewController.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//
import UIKit

final class LoginViewModel {
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    let manager = NetworkManager()
    
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            print("❌ Ошибка: Пустые поля email или password")
            onLoginFailure?("Fields are empty")
            return
        }
        
        let params: [String: Any] = ["username": email, "password": password]
        print("📤 Отправка запроса с параметрами: \(params)")
        
        manager.request(endpoint: .login, model: AuthResponse.self, method: .post, params: params, encodingType: .json) { [weak self] response, error in
            
            if let error = error {
                print("❌ Ошибка при запросе: \(error)")
                self?.onLoginFailure?(error)
                return
            }
            
            if let response = response {
                print("✅ Успешный вход! Получен токен: \(response.accessToken)")
                AuthManager.shared.accessToken = response.accessToken
                AuthManager.shared.refreshToken = response.refreshToken
                print("✅ onLoginSuccess в LoginViewModel сработал!")
                self?.onLoginSuccess?()
            } else {
                print("⚠️ Неизвестная ошибка: Пустой response")
                self?.onLoginFailure?("An unknown error occurred")
            }
        }
    }
}
