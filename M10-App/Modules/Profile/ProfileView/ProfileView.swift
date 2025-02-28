//
//  ProfileView.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
import UIKit

final class ProfileViewController: UIViewController {
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .gray
        button.addAction(UIAction { [weak self] _ in
            self?.dismiss(animated: true)
        }, for: .touchUpInside)
        return button
    }()
    
    
    private lazy var avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle.fill")
        iv.tintColor = .gray
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(closeButton)
        view.addSubview(avatarImageView)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
