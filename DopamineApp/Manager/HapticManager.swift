//
//  HapticManager.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/14/24.
//

import SwiftUI

    final class HapticManager {
        static let shared = HapticManager()
        private init() { }
        
        private let heavy = UIImpactFeedbackGenerator(style: .heavy)
        private let medium = UIImpactFeedbackGenerator(style: .medium)
        
        func heavyHaptic() {
            heavy.impactOccurred()
        }
        func mediumHaptic() {
            medium.impactOccurred()
        }
    }
