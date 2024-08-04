////
////  NavigationManager.swift
////  DopamineApp
////
////  Created by Yujin Son on 8/3/24.
////
//
//import SwiftUI
//
//final class NavigationManager: ObservableObject {
//    @Published var screenPath: [AppScreen] = []
//    @Published var startDate: Date? = nil
//    @Published var endDate: Date? = nil
//
//}
//
//enum AppScreen: Hashable, Identifiable, CaseIterable {
//    case base
//    case title
//    case calendar
//    case list
//    case plan
//    
//    var id: AppScreen { self }
//}
//
//extension AppScreen {
//    
//    @ViewBuilder
//    func destination(with manager: NavigationManager) -> some View {
//        switch self {
//        case .base:
//            BaseView()
//        case .title:
//            TitleView()
//        case .calendar:
//            ScheduleSettingView()
//        case .list:
//            PlanSettingView()
//        case .plan:
//            PlanView(startDate: manager.startDate ?? Date(), endDate: manager.endDate ?? Date())
//        }
//    }
//}
//
//
////#Preview {
////    NavigationManager()
////}
