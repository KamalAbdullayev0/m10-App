import UIKit
import AVKit

class CustomButton: UIView {
    
    private var action: (() -> Void)?
    
    private let colorView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.bluedarkColor
        view.layer.cornerRadius = 35
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 28, weight: .regular)
        button.layer.cornerRadius = 35
        return button
    }()
    
    init(buttonText: String, height: CGFloat, width: CGFloat,textColor: UIColor = Resources.Colors.bluedarkColor,
         backgroundColor: UIColor = .white,fontSize: CGFloat = 28, action: @escaping () -> Void) {
        self.action = action
        super.init(frame: .zero)
        self.isUserInteractionEnabled = true
        
        colorView.layer.cornerRadius = height / 2
        actionButton.layer.cornerRadius = height * 0.89 / 2
        
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.setTitleColor(textColor, for: .normal)
        actionButton.backgroundColor = backgroundColor
        actionButton.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .regular)
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        addSubview(colorView)
        addSubview(actionButton)
        
        colorView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            colorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            colorView.widthAnchor.constraint(equalToConstant: width),
            colorView.heightAnchor.constraint(equalToConstant: height),
            
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: width * 0.96),
            actionButton.heightAnchor.constraint(equalToConstant: height * 0.89),
            actionButton.topAnchor.constraint(equalTo: colorView.topAnchor, constant: 2),
            actionButton.leftAnchor.constraint(equalTo: colorView.leftAnchor, constant: 3),
        ])
    }
    
    @objc private func buttonTapped() {
        print("salam")
        action?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
