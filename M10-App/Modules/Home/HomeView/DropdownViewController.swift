//
//  DropdownViewController.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
import UIKit

final class DropdownViewController: UIViewController {
    private var currentState: DropdownState = .expanded
    private var panInitialState: DropdownState?
    
    private lazy var headerView: DropdownHeaderView = {
        let view = DropdownHeaderView()
        view.onCloseButtonTap = { [weak self] in
            self?.animateTransition(to: .collapsed)
        }
        return view
    }()
    
    
    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //UIKIt bottom sheet modal present 3 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(headerView)
        view.addSubview(grabberView)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            grabberView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            grabberView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: 50),
            grabberView.heightAnchor.constraint(equalToConstant: 4),
            
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        ])
    }
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    func updateUI(for state: DropdownState) {
        currentState = state
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .began:
            panInitialState = currentState
        case .changed:
            guard let initialState = panInitialState else { return }
            handlePanChanged(translation: translation, initialState: initialState)
        case .ended, .cancelled:
            guard let initialState = panInitialState else { return }
            handlePanEnded(velocity: velocity, initialState: initialState)
            panInitialState = nil
        default:
            break
        }
    }
    
    private func handlePanChanged(translation: CGPoint, initialState: DropdownState) {
        let maxY = view.bounds.height * (1 - Constants.dropdownCollapsedHeightMultiplier)
        let minY: CGFloat = 0
        let newY: CGFloat = initialState == .expanded ? min(max(translation.y, minY), maxY) : max(maxY + translation.y, minY)
        
        view.transform = CGAffineTransform(translationX: 0, y: newY)
    }
    
    private func handlePanEnded(velocity: CGPoint, initialState: DropdownState) {
        let currentY = view.transform.ty
        let maxY = view.bounds.height * (1 - Constants.dropdownCollapsedHeightMultiplier)
        let shouldToggle = (initialState == .expanded && (velocity.y > 1000 || currentY > maxY * 0.5)) ||
                           (initialState == .collapsed && (velocity.y < -1000 || currentY < maxY * 0.5))
        
        animateTransition(to: shouldToggle ? (initialState == .expanded ? .collapsed : .expanded) : initialState)
    }
    
    func animateTransition(to state: DropdownState) {
        let heightMultiplier = state == .expanded ?
        Constants.dropdownExpandedHeightMultiplier * 1.2195 : Constants.dropdownCollapsedHeightMultiplier
        let yOffset = view.frame.height * (1 - heightMultiplier)
        
        UIView.animate(withDuration: Constants.animationDuration,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5) {
            self.view.transform = CGAffineTransform(translationX: 0, y: yOffset)
        } completion: { _ in
            self.currentState = state
            self.updateUI(for: state)
        }
    }
}
