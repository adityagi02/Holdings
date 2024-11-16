//
//  AppDelegate.swift
//  UpstoxHolding
//
//  Created by Aditya Tyagi on 17/11/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = HoldingsViewController(viewModel: HoldingsViewModel(getHoldingsUseCase: GetHoldingUseCaseImpl(repository: HoldingsRepositoryImpl(networkManager: NetworkManagerImpl.shared))))
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
