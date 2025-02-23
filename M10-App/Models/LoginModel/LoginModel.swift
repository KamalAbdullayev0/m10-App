//
//  LoginModel.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 06.02.25.
//
import Foundation

// MARK: - AuthResponse
struct AuthResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let profileImageUrl: String?
    let type: String
}
