//
//  LoginError.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
enum LoginError: Error {
    case invalidCredentials
    case networkError(String)
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidCredentials:
            return "İstifadəçi adı və ya parol yanlışdır!"
        case .networkError(_):
            return "İstifadəçi adı və ya parol yanlışdır!"
        case .unknownError:
            return "Bilinməyən xəta baş verdi."
        }
    }
}
