//
//  LoginView.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//

import UIKit

final class LoginView: UIViewController {
    private let viewModel: LoginViewModel
    
    var onLoginSuccess: (() -> Void)?
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let logoView = SVGImageLoader.loadSVG(named: "logoO", width: 107, height: 120, cornerRadius: 20)
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = Resources.Colors.blackColor
        label.text = "Salam 👋"
        return label
    }()
    private let emailField = CustomTextField(
        placeholder: "Enter your email",
        height: 60,
        width: 335,
        icon: UIImage(systemName: "person")
    )
    private let passwordField = CustomTextField(
        placeholder: "Enter your password",
        height: 60,
        width: 335,
        icon: UIImage(systemName: "lock")
    )
    
    private lazy var loginButton: CustomButton = {
        return CustomButton(buttonText: "Təsdiqlə", height: 60, width: 210) { [weak self] in
            self?.handleLogin()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onLoginSuccess = { [weak self] in
            print("✅ onLoginSuccess в LoginView сработал!")
            self?.onLoginSuccess?()
        }
        view.backgroundColor = .white
        setupUI()
        setupTapGesture()
    }
    private func setupUI() {
        view.addSubview(logoView)
        view.addSubview(bottomLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.centerXAnchor),
            logoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoView.widthAnchor.constraint(equalToConstant: 107),
            logoView.heightAnchor.constraint(equalToConstant: 120),
            
            bottomLabel.centerXAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.centerXAnchor),
            bottomLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 20),
            
            emailField.centerXAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.centerXAnchor),
            emailField.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 40),
            emailField.widthAnchor.constraint(equalToConstant: 335),
            emailField.heightAnchor.constraint(equalToConstant: 60),
            
            passwordField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20),
            passwordField.widthAnchor.constraint(equalToConstant: 335),
            passwordField.heightAnchor.constraint(equalToConstant: 60),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func handleLogin() {
        let email = emailField.text
        let password = passwordField.text
        viewModel.login(email: email, password: password)
    }
}
