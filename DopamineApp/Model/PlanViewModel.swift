////
////  PlanViewModel.swift
////  DopamineApp
////
////  Created by Yujin Son on 8/16/24.
////
//
//import SwiftUI
//
//class PlanViewModel: ObservableObject {
//    @Published var startDate: Date
//    @Published var endDate: Date
//    @Published var currentViewPage: Date
//    @Published var todoItems: [[String]]
//    @Published var editedItems: [String]
//    
//    var modifiedCount: Int {
//        editedItems.count
//    }
//    
//    var unplannedCount: Int = 0
//    
//    init(startDate: Date, endDate: Date, todoItems: [[String]]) {
//        self.startDate = startDate
//        self.endDate = endDate
//        self.currentViewPage = startDate
//        self.todoItems = todoItems
//        self.editedItems = []
//    }
//    
//    func changePage(by value: Int) {
//        let calendar = Calendar.current
//        if let newPage = calendar.date(byAdding: .day, value: value, to: currentViewPage),
//           newPage >= startDate && newPage <= endDate {
//            currentViewPage = newPage
//        }
//    }
//    
//    func updateTodoItem(dayIndex: Int, index: Int, newValue: String) {
//        if dayIndex < todoItems.count && index < todoItems[dayIndex].count {
//            todoItems[dayIndex][index] = newValue
//            if !editedItems.contains(newValue) {
//                editedItems.append(newValue)
//            }
//        }
//    }
//    
//    func markTripAsEnded() {
//        unplannedCount += 1
//    }
//}
