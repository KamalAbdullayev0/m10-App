import UIKit

final class ProfileViewController: UIViewController {
    
    private let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        blurView.alpha = 0.85 // Регулируйте значение от 0 до 1
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.circle.fill")
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    private lazy var logoutButton: CustomButton = {
        let button = CustomButton(buttonText: "Hesabdan çıxış", height: 70,width: 260, textColor: .white,backgroundColor: Resources.Colors.redColor,fontSize: 22) { [weak self] in
            self?.handleLogoutTap()
        }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Установка фона для затемнения
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1) // Полупрозрачный черный фон
        
        // Добавляем размытие на задний фон
        view.insertSubview(blurEffectView, at: 0)
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0.85
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside))
        view.addGestureRecognizer(tapGesture)
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -140),
            avatarImageView.widthAnchor.constraint(equalToConstant: 360),
            avatarImageView.heightAnchor.constraint(equalToConstant: 360),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70),
            logoutButton.heightAnchor.constraint(equalToConstant: 62),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func handleTapOutside() {
        dismiss(animated: true, completion: nil)
    }
    
    private func handleLogoutTap() {
        viewModel.onLogout?()
        dismiss(animated: true, completion: nil)
    }
}
