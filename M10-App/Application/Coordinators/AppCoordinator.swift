//
//  AppCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow
    private var loginCoordinator: LoginCoordinator?
    private var mainCoordinator: MainCoordinator?
    private var getStartedCoordinator: GetStartedCoordinator?
    private var noInternetCoordinator: NoInternetCoordinator?
    private var lastCoordinator: AnyObject?
    
    init(window: UIWindow) {
        self.window = window
        NotificationCenter.default.addObserver(self, selector: #selector(didDetectNoInternet), name: .noInternetDetected, object: nil)
        print("✅ AppCoordinator подписан на NotificationCenter")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        print("❌ AppCoordinator деинициализирован")
    }
    
    func start() {
        print("🔄 AppCoordinator start()")
//        didDetectNoInternet()
        hasValidToken() ? showMainFlow() : showGetStartedFlow()
    }
    
    private func showGetStartedFlow() {
        print("➡️ Переход к потоку регистрации/начала")
        lastCoordinator = getStartedCoordinator
        getStartedCoordinator = GetStartedCoordinator(window: window)
        getStartedCoordinator?.onFinish = { [weak self] in
            self?.showLoginFlow()
        }
        getStartedCoordinator?.start()
    }
    
    private func showLoginFlow() {
        print("➡️ Переход к потоку входа")
        lastCoordinator = loginCoordinator
        loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator?.start()
    }
    
    private func showMainFlow() {
        print("➡️ Переход к главному потоку")
        lastCoordinator = mainCoordinator
        mainCoordinator = MainCoordinator(window: window)
        mainCoordinator?.onLogout = { [weak self] in
            self?.logout()
        }
        mainCoordinator?.start()
    }
    
    private func hasValidToken() -> Bool {
        print("🔑 Проверка наличия валидного токена")
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        let refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        return accessToken != nil || refreshToken != nil
    }
    
    private func logout() {
        print("🚪 Пользователь выходит из системы...")
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        showGetStartedFlow()
    }
    
    @objc private func didDetectNoInternet() {
        print("⚠️ Обнаружена потеря интернета. Сохранение текущего координатора...")
        lastCoordinator = currentCoordinator()
        print("✅ Сохранен текущий координатор: \(String(describing: lastCoordinator))")
        
        noInternetCoordinator = NoInternetCoordinator(window: window)
        noInternetCoordinator?.onInternetRestored = { [weak self] in
            self?.didRestoreInternet()
        }
        noInternetCoordinator?.start()
    }
    
    @objc private func didRestoreInternet() {
        print("✅ Интернет восстановлен. Восстановление предыдущего потока...")
        noInternetCoordinator = nil
        restoreLastFlow()
        lastCoordinator = nil
    }
    
    private func currentCoordinator() -> AnyObject? {
        print("🔄 Определение текущего координатора")
        return getStartedCoordinator ?? loginCoordinator ?? mainCoordinator
    }
    
    private func restoreLastFlow() {
        print("🔄 Восстановление последнего потока")
        if let lastCoordinator = lastCoordinator as? LoginCoordinator {
            lastCoordinator.start()
        } else if let lastCoordinator = lastCoordinator as? GetStartedCoordinator {
            lastCoordinator.start()
        } else if let lastCoordinator = lastCoordinator as? MainCoordinator {
            lastCoordinator.start()
        } else {
            print("⚠️ Нет сохраненного координатора. Показываем главный экран.")
            showMainFlow()
        }
        self.lastCoordinator = nil
    }
}
