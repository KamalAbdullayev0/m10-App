//
//  GetTextView.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//
import UIKit

func getTextView(textField: UITextField, placeholder: String, isPassword: Bool = false) -> UIStackView {
    let action = UIAction { _ in
        textField.isSecureTextEntry.toggle()
    }
    
    let hidePasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.tintColor = .systemGray
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = placeholder
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .gray
        return label
    }()
    
    let placeholderView = UIView()
    placeholderView.addSubview(placeholderLabel)
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        placeholderLabel.leadingAnchor.constraint(equalTo: placeholderView.leadingAnchor, constant: 19),
        placeholderLabel.topAnchor.constraint(equalTo: placeholderView.topAnchor),
        placeholderLabel.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor)
    ])
    
    let fieldView = UIView()
    fieldView.backgroundColor = .systemGray5
    fieldView.layer.cornerRadius = 20
    fieldView.addSubview(textField)
    textField.translatesAutoresizingMaskIntoConstraints = false


    if isPassword {
        fieldView.addSubview(hidePasswordButton)
        hidePasswordButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    NSLayoutConstraint.activate([
        textField.leadingAnchor.constraint(equalTo: fieldView.leadingAnchor, constant: 10),
        textField.trailingAnchor.constraint(equalTo: isPassword ? hidePasswordButton.leadingAnchor : fieldView.trailingAnchor, constant: -10),
        textField.centerYAnchor.constraint(equalTo: fieldView.centerYAnchor),
        fieldView.heightAnchor.constraint(equalToConstant: 60)
    ])
    

    if isPassword {
        NSLayoutConstraint.activate([
            hidePasswordButton.trailingAnchor.constraint(equalTo: fieldView.trailingAnchor, constant: -10),
            hidePasswordButton.centerYAnchor.constraint(equalTo: fieldView.centerYAnchor)
        ])
    }
    
    let stackView = UIStackView(arrangedSubviews: [placeholderView, fieldView])
    stackView.axis = .vertical
    stackView.spacing = 7
    return stackView
}
