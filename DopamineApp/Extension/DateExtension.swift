//
//  DateExtension.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/7/24.
//

import SwiftUI
import Foundation

extension Date {
    func numberOfDays(to endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: self, to: endDate)
        return max(0, components.day ?? 0) + 1
    }
}
