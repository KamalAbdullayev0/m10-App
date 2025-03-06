//
//  DropdownHeaderiew.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
import UIKit

final class DropdownHeaderView: UIView {
    var onOptionSelected: ((String) -> Void)?
    var onCloseButtonTap: (() -> Void)?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray
        button.addTarget(self, action: #selector(handleCloseTap), for: .touchUpInside)
        return button
    }()
    // В вашем DropdownHeaderView
    private lazy var dropdownSelector: DropdownSelectorView<String> = {
            let dropdown = DropdownSelectorView<String>(options: ["Яблоко", "Банан", "Вишня"])
            dropdown.onOptionSelected = { [weak self] selectedOption in
                self?.onOptionSelected?(selectedOption)
            }
            return dropdown
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(closeButton)
        addSubview(dropdownSelector)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        dropdownSelector.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            closeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
            dropdownSelector.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                       dropdownSelector.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -10),
                       dropdownSelector.centerYAnchor.constraint(equalTo: centerYAnchor),
                       dropdownSelector.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func handleCloseTap() {
        onCloseButtonTap?()
    }
}
