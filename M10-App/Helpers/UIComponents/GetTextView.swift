//
//  GetTextView.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 21.01.25.
import UIKit

func createTextField(placeholder: String, fontSize: CGFloat = 16, width: CGFloat? = nil, height: CGFloat = 50, isPassword: Bool = false) -> UIView {
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.font = UIFont.systemFont(ofSize: fontSize)
    textField.borderStyle = .none
    textField.isSecureTextEntry = isPassword
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    let containerView = UIView()
    containerView.layer.cornerRadius = 10
    containerView.layer.borderWidth = 1
    containerView.layer.borderColor = UIColor.systemGray.cgColor
    containerView.translatesAutoresizingMaskIntoConstraints = false
    containerView.addSubview(textField)

    if let width = width {
        containerView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    containerView.heightAnchor.constraint(equalToConstant: height).isActive = true

    let padding: CGFloat = 10
    
    var constraints = [
        textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
        textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
        textField.heightAnchor.constraint(equalToConstant: height - 10)
    ]
    
    if isPassword {
        let action = UIAction { _ in
            textField.isSecureTextEntry.toggle()
        }
        
        let hidePasswordButton = UIButton(type: .system)
        hidePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        hidePasswordButton.tintColor = .systemGray
        hidePasswordButton.addAction(action, for: .touchUpInside)
        hidePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(hidePasswordButton)
        
        constraints.append(contentsOf: [
            hidePasswordButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            hidePasswordButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.trailingAnchor.constraint(equalTo: hidePasswordButton.leadingAnchor, constant: -padding)
        ])
    }

    NSLayoutConstraint.activate(constraints)
    
    return containerView
}
