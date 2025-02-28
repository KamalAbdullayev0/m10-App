//
//  HomeHeaderView.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
import UIKit

// MARK: - HomeHeaderView
final class HomeHeaderView: UIView {
    
    var onProfileTap: (() -> Void)?
    var onDropdownTap: (() -> Void)?
    
    private lazy var profileButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 46, weight: .regular)
        button.setImage(UIImage(systemName: "person.circle.fill")?.withConfiguration(config), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfileTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Salam"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        return label
    }()
    private lazy var title2Label: UILabel = {
        let label = UILabel()
        label.text = "İşə başlamaq üçün bron edin!"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var dropdownButton: UIButton = {
        let button = UIButton()
        
        if let originalImage = UIImage(named: "3dot") {
            let newSize = CGSize(width: 28, height: 28)
            let renderer = UIGraphicsImageRenderer(size: newSize)
            let resizedImage = renderer.image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: newSize))
            }
            button.setImage(resizedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        button.tintColor = .red
        button.addTarget(self, action: #selector(handleDropdownTap), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileButton)
        addSubview(title2Label)
        addSubview(titleLabel)
        addSubview(dropdownButton)
        
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        title2Label.translatesAutoresizingMaskIntoConstraints = false
        dropdownButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
                profileButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                profileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                profileButton.widthAnchor.constraint(equalToConstant: 60),
                profileButton.heightAnchor.constraint(equalToConstant: 60),
                
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                
                title2Label.centerXAnchor.constraint(equalTo: centerXAnchor),
                title2Label.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
                
                dropdownButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                dropdownButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                dropdownButton.widthAnchor.constraint(equalToConstant: 28),
                dropdownButton.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    @objc private func handleProfileTap() {
        onProfileTap?()
    }
    
    @objc private func handleDropdownTap() {
        onDropdownTap?()
    }
}
