//
//  NoInternetView.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import UIKit

class NoInternetView: UIViewController {
    private let viewModel: NoInternetViewModel
    
    init(viewModel: NoInternetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let customAlert: CustomAlertView = {
            let alert = CustomAlertView(
                frame: CGRect(x: 0, y: 0, width: 345, height: 20),
                message: "İnternet bağlantısı yoxdur.",
                backgroundColor: Resources.Colors.redColor,
                textColor: .white
            )
            return alert
        }()
    
    private let logoView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "no_internet"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "İnternet bağlantısı yoxdur 😔"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Bağlantını yoxla və yenidən cəhd et"
        label.textColor = Resources.Colors.softGreyTextColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var noInternetButton: CustomButton = {
        return CustomButton(
            buttonText: "Yenidən cəhd et",
            height: 60,
            width: 250,
            textColor: .white,
            backgroundColor: Resources.Colors.purple,
            fontSize: 18){ [weak self] in
            self?.retryNetworkCheck()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        viewModel.onShowNoInternetView = { [weak self] in
            self?.showTemporaryAlert()
        }
        customAlert.isHidden = true
    }

    private func setupView() {
        view.addSubview(logoView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(noInternetButton)
        view.addSubview(customAlert)
        
        logoView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        noInternetButton.translatesAutoresizingMaskIntoConstraints = false
        customAlert.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -120),
            logoView.widthAnchor.constraint(equalToConstant: 164),
            logoView.heightAnchor.constraint(equalToConstant: 159),
            
            
            titleLabel.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            customAlert.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    customAlert.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    customAlert.widthAnchor.constraint(equalToConstant: 345),
                    customAlert.heightAnchor.constraint(equalToConstant: 45),
                
            
            noInternetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noInternetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noInternetButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor,constant: 250)
        ])
    }
    private func showTemporaryAlert() {
        customAlert.alpha = 0
        customAlert.isHidden = false
        
        UIView.animate(withDuration: 0.2, animations: {
            self.customAlert.alpha = 1        }) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    UIView.animate(withDuration: 0.2) {
                        self.customAlert.alpha = 0
                    } completion: { _ in
                        self.customAlert.isHidden = true
                    }
                }
            }
    }
    private func retryNetworkCheck() {
        viewModel.checkInternetConnection()
    }
}
