//
//  Main.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//
import UIKit
final class TabbarController: UITabBarController {
    var onLogout: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        customizeTabBarAppearance()
    }
    
    private func configureTabs() {
            
        let searchController = SearchViewModel()
                searchController.onLogout = { [weak self] in
                    self?.onLogout?() // Это передаст сигнал в `MainCoordinator`
                }
        let profileController = ProfileViewModel()

        // Настройка для Search Tab
        searchController.tabBarItem = UITabBarItem(
            title: "Search",
            image: .search.withRenderingMode(.alwaysTemplate),
            tag: 0
        )

        // Настройка для Profile Tab
        profileController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: .person.withRenderingMode(.alwaysTemplate),
            tag: 1
            
        )
        
        // Добавление навигационных контроллеров
        let searchNavigation = NavBarController(rootViewController: searchController)
        let profileNavigation = NavBarController(rootViewController: profileController)
        
        setViewControllers([searchNavigation, profileNavigation], animated: false)
    }
    
    private func customizeTabBarAppearance() {
        // Цвет фона таба
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        
        // Убираем тень и устанавливаем границу
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = Resources.Colors.greyColor.cgColor
        tabBar.layer.masksToBounds = true
        
        // Настройка цвета для иконок и текста
        tabBar.tintColor = Resources.Colors.greenlightColor // Цвет для выбранного элемента
        tabBar.unselectedItemTintColor = Resources.Colors.greyTextColor // Цвет для невыбранных элементов

        // Настройка стиля текста для выбранных и невыбранных вкладок
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: Resources.Colors.greenlightColor], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: Resources.Colors.greyTextColor], for: .normal)
        
        // Добавление тени
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowRadius = 4
    }
}
