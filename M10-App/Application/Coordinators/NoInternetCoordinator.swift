//  NoInternetCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import UIKit

final class NoInternetCoordinator {
    private let window: UIWindow
//    private var timer: Timer?
    var onInternetRestored: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
        print("🌐 [NoInternetCoordinator] Инициализирован. Ожидание восстановления сети...")
//        startCheckingInternet()
    }
    
    func start() {
        print("📡 [NoInternetCoordinator] Запуск. Отображение экрана без интернета...")
        
//        let viewModel = GetStartedViewModel()
//        viewModel.onGetStarted = { [weak self] in
//            self?.onFinish?()
//        }
//        let getStartedViewController = GetStartedView(viewModel: viewModel)
        let viewModel = NoInternetViewModel()
        let noInternetViewController = NoInternetView(viewModel: viewModel)
        window.rootViewController = noInternetViewController
        window.makeKeyAndVisible()
    }
    
//    private func startCheckingInternet() {
//        print("⏳ [NoInternetCoordinator] Ждем 15 секунд перед проверкой интернета...")
//        timer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(checkAndRestore), userInfo: nil, repeats: false)
//    }
    
//    @objc private func checkAndRestore() {
//        guard NetworkMonitor.shared.isConnected else {
//            print("❌ [NoInternetCoordinator] Интернет все еще отсутствует. Перезапуск таймера...")
//            startCheckingInternet()
//            return
//        }
//        print("✅ [NoInternetCoordinator] Интернет подключен. Отправка уведомления...")
//        onInternetRestored?()
//        cleanup()
//    }
    
//    private func cleanup() {
//        timer?.invalidate()
//        timer = nil
//    }
//    
//    deinit {
//        cleanup()
//    }
}
