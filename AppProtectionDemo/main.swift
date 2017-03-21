//
//  main.swift
//  AppProtectionDemo
//
//  Created by Thomas Reinberger on 15.03.17.
//  Copyright © 2017 Thomas Reinberger. All rights reserved.
//

import Foundation
import UIKit

UIApplicationMain(
    CommandLine.argc,
    UnsafeMutableRawPointer(CommandLine.unsafeArgv)
        .bindMemory(
            to: UnsafeMutablePointer<Int8>.self,
            capacity: Int(CommandLine.argc)),
    NSStringFromClass(TimeoutManagerApp.self),
    NSStringFromClass(AppDelegate.self)
)
