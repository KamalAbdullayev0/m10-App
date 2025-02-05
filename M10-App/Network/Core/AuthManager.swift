//
//  AuthManager.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import Foundation

class AuthManager {
    static let shared = AuthManager()

    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"

    var accessToken: String? {
        get { UserDefaults.standard.string(forKey: accessTokenKey) }
        set { UserDefaults.standard.setValue(newValue, forKey: accessTokenKey) }
    }

    var refreshToken: String? {
        get { UserDefaults.standard.string(forKey: refreshTokenKey) }
        set { UserDefaults.standard.setValue(newValue, forKey: refreshTokenKey) }
    }

    func clearTokens() {
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
    }
}
