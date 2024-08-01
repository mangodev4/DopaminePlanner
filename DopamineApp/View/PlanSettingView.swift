//
//  PlanSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/27/24.
//

import SwiftUI

struct PlanSettingView: View {
    var startDate: Date
    var endDate: Date
    
    @State private var currentPage: Date
     
     init(startDate: Date, endDate: Date) {
         self.startDate = startDate
         self.endDate = endDate
         _currentPage = State(initialValue: startDate)
     }
    
    var body: some View {
        VStack {
            headerView
            pageView
        }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)

    }
    
    private var headerView: some View {
        HStack {
            Button(action: {
                changePage(by: -1)
            }){
                Image(systemName: "chevron.left")
            }
            Spacer()
            
            Text(currentPage, formatter: Self.dateFormatter)
                .font(.pretendardBold20)
            
            Spacer()
            
            Button(action: {
                changePage(by: 1)
            }) {
                Image(systemName: "chevron.right")
            }
        
            .padding()
        }
    }
    
    
    private var pageView: some View {
        VStack {
            Text("할 일 목록")
                .font(.pretendardMedium20)
        }
        .onAppear{
            currentPage = startDate
        }
    }
    
    private func changePage(by value: Int) {
        let calendar = Calendar.current
        if let newPage = calendar.date(byAdding: .day, value: value, to: currentPage),
           newPage >= startDate && newPage <= endDate {
            currentPage = newPage
        }
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}




//#Preview {
//    PlanSettingView(startDate: $startDate, endDate: $endDate)
//}
