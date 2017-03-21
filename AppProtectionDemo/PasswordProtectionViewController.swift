//
//  PasswordProtectionViewController.swift
//  AppProtectionDemo
//
//  Created by Thomas Reinberger on 17.03.17.
//  Copyright © 2017 Thomas Reinberger. All rights reserved.
//

import UIKit

protocol PasswordProtectionViewControllerDelegate {
    func didTapLogin()
}

class PasswordProtectionViewController: UIViewController {

    private let delegate: PasswordProtectionViewControllerDelegate

    init(delegate: PasswordProtectionViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        delegate.didTapLogin()
    }

}
