//
//  NoInternetView.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import UIKit

class NoInternetView: UIViewController {
    private let viewModel: NoInternetViewModel
    private let refreshControl = UIRefreshControl()
    init(viewModel: NoInternetViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .white

        let label = UILabel()
        label.text = "Нет соединения"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        let scrollView = UIScrollView()
        scrollView.refreshControl = refreshControl
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        refreshControl.addTarget(self, action: #selector(refreshInternetConnection), for: .valueChanged)

        view.addSubview(scrollView)
        scrollView.addSubview(label)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        ])
    }

    @objc private func refreshInternetConnection() {
            refreshControl.endRefreshing()
            viewModel.checkInternetAndRestore()
        }
}

