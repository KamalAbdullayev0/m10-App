//
//  CustomAlert.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 24.02.25.
//
import UIKit

class CustomAlertView: UIView {
    
    private var messageLabel: UILabel!
    
    init(frame: CGRect, message: String, backgroundColor: UIColor, textColor: UIColor) {
        super.init(frame: frame)
        setupView(message: message, backgroundColor: backgroundColor, textColor: textColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(message: String, backgroundColor: UIColor, textColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 14
        
        messageLabel = UILabel()
        messageLabel?.text = message
        messageLabel.textColor = textColor
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        messageLabel.textAlignment = .center
        
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: 360),
            messageLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 360),
            self.heightAnchor.constraint(equalToConstant: 28),
        ])
    }
    
    func updateMessage(_ message: String) {
        messageLabel.text = message
    }
    
    func updateBackgroundColor(_ color: UIColor) {
        self.backgroundColor = color
    }
    
    func updateTextColor(_ color: UIColor) {
        messageLabel.textColor = color
    }
}
