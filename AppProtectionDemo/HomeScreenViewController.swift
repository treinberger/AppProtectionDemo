//
//  HomeScreenViewController.swift
//  AppProtectionDemo
//
//  Created by Thomas Reinberger on 17.03.17.
//  Copyright © 2017 Thomas Reinberger. All rights reserved.
//

import UIKit

protocol HomeScreenViewControllerDelegate {
    func didTapOpenAnotherScreen()
}

class HomeScreenViewController: UIViewController {

    private let delegate: HomeScreenViewControllerDelegate
    @IBOutlet weak var switchPasswordProtection: UISwitch!

    init(delegate: HomeScreenViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        switchPasswordProtection.isOn = UserDefaults.standard.value(forKey: Constants.HAS_PASSWORD_PROTECTION) as! Bool
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func didChangePasswordSwitchStatus(_ sender: Any) {
        UserDefaults.standard.setValue(switchPasswordProtection.isOn, forKey: Constants.HAS_PASSWORD_PROTECTION)
    }

    @IBAction func didTapOpenAnotherScreen(_ sender: UIButton) {
        delegate.didTapOpenAnotherScreen()
    }
}
