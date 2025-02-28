//
//  HomeView.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
import UIKit

// MARK: - HomeViewController
final class HomeViewController: UIViewController {
    
    private let viewModel: HomeViewModel
    weak var coordinator: HomeCoordinator?
    private var dropdownViewController: DropdownViewController!
    private var dropdownState: DropdownState = .expanded
    
    private lazy var headerView: HomeHeaderView = {
        let view = HomeHeaderView()
        view.onProfileTap = { [weak self] in
            self?.didTapProfile()
        }
        view.onDropdownTap = { [weak self] in
            self?.toggleDropdownState()
        }
        return view
    }()
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDropdown()
    }
    
    private func setupUI() {
        view.backgroundColor = Resources.Colors.greenlightColor
        
        view.addSubview(headerView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            headerView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setupDropdown() {
        dropdownViewController = DropdownViewController()
        addChild(dropdownViewController)
        view.addSubview(dropdownViewController.view)
        dropdownViewController.didMove(toParent: self)
        
        dropdownViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dropdownViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dropdownViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dropdownViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dropdownViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Constants.dropdownExpandedHeightMultiplier)
        ])
        
        dropdownViewController.view.layer.cornerRadius = Constants.cornerRadius
        dropdownViewController.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        dropdownViewController.view.addShadow(opacity: Constants.shadowOpacity, radius: Constants.shadowRadius)
    }
    
    private func didTapProfile() {
        coordinator?.showProfile()
    }
    
    private func toggleDropdownState() {
        let newState: DropdownState = dropdownState == .expanded ? .collapsed : .expanded
        dropdownState = newState
        dropdownViewController.animateTransition(to: newState)
    }
    
    
}
