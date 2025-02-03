//
//  LoginView.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//

import UIKit

final class LoginView: UIView {
    let emailField = UITextField()
    let passwordField = UITextField()
    let loginButton = UIButton(type: .system)
    private let bannerView = BannerView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .white
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bannerView)
        
        NSLayoutConstraint.activate([
            bannerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bannerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        let emailStack = getTextView(
            textField: emailField,
            placeholder: "Enter your email"
        )
        let passwordStack = getTextView(
            textField: passwordField,
            placeholder: "Enter your password",
            isPassword: true
        )
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor.systemGreen
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [emailStack, passwordStack, loginButton])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(10, after: emailStack)
        stackView.setCustomSpacing(200, after: passwordStack)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -40),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
    }
}
