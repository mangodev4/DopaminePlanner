//
//  DopamineAppApp.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/25/24.
//

import SwiftUI

@main
struct DopamineAppApp: App {
    @State private var modifiedCount: Int = 0
    @State private var unplannedCount: Int = 0

    var body: some Scene {
        WindowGroup {
            ContentView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)
        }
    }
}
