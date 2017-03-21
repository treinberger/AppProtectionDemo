//
//  AnotherScreenViewController.swift
//  AppProtectionDemo
//
//  Created by Thomas Reinberger on 17.03.17.
//  Copyright © 2017 Thomas Reinberger. All rights reserved.
//

import UIKit

protocol AnotherScreenViewControllerDelegate {
    func didTapBack()
}

class AnotherScreenViewController: UIViewController {

    private let delegate: AnotherScreenViewControllerDelegate

    init(delegate: AnotherScreenViewControllerDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func didTapBackButton(_ sender: UIButton) {
        delegate.didTapBack()
    }
}
