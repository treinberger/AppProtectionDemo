//
//  TimeoutManagerApp.swift
//  AppProtectionDemo
//
//  Created by Thomas Reinberger on 15.03.17.
//  Copyright © 2017 Thomas Reinberger. All rights reserved.
//

import Foundation
import UIKit

class TimeoutManagerApp: UIApplication {

    private var timer = Timer()
    private var secondsPassedSinceLastInteraction = 0
    private var maxSecondsForUserInactivity = 10

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)

        if event.allTouches != nil {
            let touchPhase = (event.allTouches!.first!).phase

            if touchPhase == .ended {
                self.startInactivityTimer()
            }
        }
    }

    fileprivate func startInactivityTimer() {
        self.secondsPassedSinceLastInteraction = 0
        self.timer.invalidate()

        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkIfAppNeedsToBeLocked), userInfo: nil, repeats: true)
    }

    @objc fileprivate func checkIfAppNeedsToBeLocked() {
        if self.secondsPassedSinceLastInteraction < Constants.TIMEOUT_MANAGER_TIMEOUT {
            self.secondsPassedSinceLastInteraction += 1
        } else {
            self.timer.invalidate()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.TIMEOUT_MANAGER_TRIGGERED), object: nil)
        }
    }

}
