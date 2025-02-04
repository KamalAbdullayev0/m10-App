//
//  SearchViewModel.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//

import UIKit

final class SearchViewModel: UIViewController {
    var onLogout: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }

    private func setupUI() {
        setupLogoutButton()
    }

    private func setupLogoutButton() {
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        navigationItem.rightBarButtonItem = logoutButton
    }

    @objc private func logoutTapped() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn") // Удаляем логин
        onLogout?() // Сообщаем координатору, что нужно перейти на экран входа
    }
}
