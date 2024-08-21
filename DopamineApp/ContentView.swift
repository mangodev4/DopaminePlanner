//
//  ContentView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/25/24.
//

import SwiftUI
import Combine
import Foundation

struct ContentView: View {
    
    @Binding var modifiedCount: Int
    @Binding var unplannedCount: Int

    
    var body: some View {
        
//        ScheduleSettingView()
        BaseView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)
        
    }
}
//
//#Preview {
//    ContentView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)
//}
