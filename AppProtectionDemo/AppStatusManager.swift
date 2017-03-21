//
//  AppStatusManager.swift
//  AppProtectionDemo
//
//  Created by Thomas Reinberger on 15.03.17.
//  Copyright © 2017 Thomas Reinberger. All rights reserved.
//

import Foundation
import UIKit

class AppStatusManager: NSObject, HomeScreenViewControllerDelegate, AnotherScreenViewControllerDelegate, PasswordProtectionViewControllerDelegate {
    private let window: UIWindow
    private let notificationCenter: NotificationCenter
    private var lastViewController: UIViewController?
    private var isApplicationDidEnterBackground = true
    private var isAppLocked = false

    private lazy var anotherViewController: AnotherScreenViewController = {
        let viewController = AnotherScreenViewController(delegate: self)
        return viewController
    }()

    private lazy var passwordProtectionViewController: PasswordProtectionViewController = {
        let viewController = PasswordProtectionViewController(delegate: self)
        return viewController
    }()

    private lazy var lockscreenViewController: LockScreenViewController = {
        let viewController = LockScreenViewController()
        return viewController
    }()

    private lazy var homeScreenViewController: HomeScreenViewController = {
        let viewController = HomeScreenViewController(delegate: self)
        return viewController
    }()

    func applicationWillResignActiveHandler() {
        if !(window.rootViewController is PasswordProtectionViewController || window.rootViewController is LockScreenViewController) {
            lastViewController = window.rootViewController
        }
        window.rootViewController = isPasswordProtectionActivated() ? passwordProtectionViewController : lockscreenViewController
    }

    init(_ window: UIWindow) {

        self.window = window
        self.notificationCenter = NotificationCenter.default

        super.init()

        lastViewController = homeScreenViewController
        showFirstScreen()

        addObservers()
    }

    func applicationDidEnterBackgroundHandler() {
        isApplicationDidEnterBackground = true
    }

    func applicationDidBecomeActiveHandler() {
        if !isApplicationDidEnterBackground {
            window.rootViewController = isAppLocked ? passwordProtectionViewController : lastViewController
        } else {
            showFirstScreen()
        }

        isApplicationDidEnterBackground = false
    }

    // MARK: AnotherScreenViewControllerDelegate
    func didTapBack() {
        window.rootViewController = homeScreenViewController
    }

    // MARK: HomeScreenViewControllerDelegate
    func didTapOpenAnotherScreen() {
        window.rootViewController = anotherViewController
    }

    // MARK: PasswordProtectionViewControllerDelegate
    func didTapLogin() {
        isAppLocked = false
        window.rootViewController = lastViewController
    }

    // MARK: private methods

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(lockAppWhenUserIsInactive), name: NSNotification.Name(rawValue: Constants.TIMEOUT_MANAGER_TRIGGERED), object: nil)
    }

    @objc private func lockAppWhenUserIsInactive() {
        if isPasswordProtectionActivated() {
            isAppLocked = true
            window.rootViewController = passwordProtectionViewController
        }
    }

    private func isPasswordProtectionActivated() -> Bool {
        // TODO: replace with application-specific implementation
        if (UserDefaults.standard.value(forKey: Constants.HAS_PASSWORD_PROTECTION) as? Bool) == nil {
            UserDefaults.standard.set(false, forKey: Constants.HAS_PASSWORD_PROTECTION)
        }

        return UserDefaults.standard.value(forKey: Constants.HAS_PASSWORD_PROTECTION) as! Bool
    }

    private func showFirstScreen() {
        window.rootViewController = isPasswordProtectionActivated() ? passwordProtectionViewController : lastViewController
    }
}
