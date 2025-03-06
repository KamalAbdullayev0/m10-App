//
//  SharedComponents.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 26.02.25.
//
import UIKit

// MARK: - DropdownState
enum DropdownState {
    case expanded
    case collapsed
    
    var heightMultiplier: CGFloat {
        switch self {
        case .expanded: return Constants.dropdownExpandedHeightMultiplier
        case .collapsed: return Constants.dropdownCollapsedHeightMultiplier
        }
    }
}

// MARK: - MenuItem
struct MenuItem {
    let title: String
    let iconName: String
}

// MARK: - DropdownViewModel
//struct DropdownViewModel {
//    let items: [MenuItem] = [
//        MenuItem(title: "Home", iconName: "house.fill"),
//        MenuItem(title: "Settings", iconName: "gearshape.fill"),
//        MenuItem(title: "Profile", iconName: "person.fill"),
//        MenuItem(title: "Logout", iconName: "arrowshape.turn.up.left.fill")
//    ]
//}

// MARK: - Constants
enum Constants {
    static let dropdownExpandedHeightMultiplier: CGFloat = 0.82
    static let dropdownCollapsedHeightMultiplier: CGFloat = 0.09
    static let animationDuration: TimeInterval = 0.4
    static let cornerRadius: CGFloat = 45
    static let shadowOpacity: Float = 0.1
    static let shadowRadius: CGFloat = 12
    static let headerHeight: CGFloat = 100
}

// MARK: - Extensions
extension UIView {
    func addShadow(opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = radius
    }
}
