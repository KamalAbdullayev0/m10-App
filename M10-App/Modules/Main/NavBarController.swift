//
//  NavBarController.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//

import UIKit

final class NavBarController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure () {
        view.backgroundColor = .white
        navigationBar.isTranslucent = false
        
    }
}
