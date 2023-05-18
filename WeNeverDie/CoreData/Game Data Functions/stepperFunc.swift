//
//  stepperFunc.swift
//  WeNeverDie
//
//  Created by Conner Yoon on 5/18/23.
//

import Foundation
extension ResourcePool {
    func balance(_ index: Int) {
        if lastTappedIndex == index {
            // Tapped the same button twice set all buttons to false
            for i in 0...index {
                selectStatuses[i] = false
            }
            survivorSent = 0
            lastTappedIndex = nil
        } else {
            // Set the survivorSent value based on the index and switchToLeft flag
            if uiSetting.switchToLeft {
                survivorSent = selectStatuses.count - index
            } else {
                survivorSent = index + 1
            }
            
            // Set the selectStatuses array based on the survivorSent value
            for i in 0..<selectStatuses.count {
                selectStatuses[i] = (i < survivorSent)
            }
            
            lastTappedIndex = index
        }
    }
}
