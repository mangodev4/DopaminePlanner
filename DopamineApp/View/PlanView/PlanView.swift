//
//  PlanView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/27/24.
//

import SwiftUI

struct PlanView: View {
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
            
            Spacer()
        }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)

    }
    
    private var headerView: some View {
        HStack {
            Spacer()

            Button(action: {
                changePage(by: -1)
            }){
                Image(systemName: "chevron.left")
            }
            Spacer()
            
            Text(currentPage, formatter: Self.dateFormatter)
                .font(.pretendardBold24)
            
            Spacer()
            
            Button(action: {
                changePage(by: 1)
            }) {
                Image(systemName: "chevron.right")
            }
            
            Spacer()
            }
        .padding(.top, 10)
    }
    
    
    private var pageView: some View {
        VStack {
            Text("할 일 목록")
                .font(.pretendardMedium20)
        }
        .onAppear{
            currentPage = startDate
        }
        .padding(.top, 5)
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
//    PlanView(startDate: $startDate, endDate: $endDate)
//}
