//
//  LoginViewController.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//
import Foundation

final class LoginViewModel {
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    private let loginUseCase: LoginUseCaseProtocol
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onLoginFailure?("Məlumatları düzgün doldurun!")
            return
        }
        
        loginUseCase.execute(email: email, password: password) { [weak self] result in
            switch result {
            case .success(let response):
                print("✅ Успешный логин, токен: \(response.accessToken)")
                AuthManager.shared.accessToken = response.accessToken
                AuthManager.shared.refreshToken = response.refreshToken
                self?.onLoginSuccess?()
            case .failure(let error):
                if let loginError = error as? LoginError {
                    self?.onLoginFailure?(loginError.localizedDescription)
                } else {
                    self?.onLoginFailure?("Bilinməyən xəta baş verdi.")
                }
            }
        }
    }
}
