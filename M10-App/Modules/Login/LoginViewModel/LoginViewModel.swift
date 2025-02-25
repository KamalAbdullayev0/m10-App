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
            onLoginFailure?("Məlumatları düzgün doldurun!")
            return
        }
        
        let params: [String: Any] = ["username": email, "password": password]
        print("📤 Отправка запроса с параметрами: \(params)")
        
        manager.request(endpoint: .login,
                        model: AuthResponse.self,
                        method: .post,
                        params: params,
                        encodingType: .json){
            [weak self] response, error in
            if let error = error {
                print("❌ Ошибка запроса: \(error)")
                self?.onLoginFailure?("İstifadəçi adı və ya parol yanlışdır!")
                return
            }
            if let response = response {
                print("✅ Успешный логин, токен: \(response.accessToken)")
                AuthManager.shared.accessToken = response.accessToken
                AuthManager.shared.refreshToken = response.refreshToken
                self?.onLoginSuccess?()
            } else {
                print("❌ Неизвестная ошибка при логине")
                self?.onLoginFailure?("An unknown error occurred")
            }
        }
    }
}
