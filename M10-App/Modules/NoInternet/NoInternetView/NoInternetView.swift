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
}
