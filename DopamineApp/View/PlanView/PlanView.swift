//
//  PlanSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/27/24.
//

import SwiftUI

struct PlanView: View {
    var startDate: Date
    var endDate: Date
    
    @State private var currentViewPage: Date
    @State private var isNavigatingToBase = false
    @Binding var todoItems: [[String]]

     init(startDate: Date, endDate: Date, todoItems: Binding<[[String]]>) {
         self.startDate = startDate
         self.endDate = endDate
         self._todoItems = todoItems
         self._currentViewPage = State(initialValue: startDate)
     }
    
    var body: some View {
        VStack {
            headerView
            pageView
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isNavigatingToBase = true
                }) {
                    Text("여행 종료")
                        .font(.pretendardBold18)
                        .foregroundColor(.gray)
                        .underline()
                }
            }
        }
        .navigationDestination(isPresented: $isNavigatingToBase) {
                BaseView()
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
            
            Text(currentViewPage, formatter: Self.dateFormatter)
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
            currentViewPage = startDate
        }
        .padding(.top, 5)
    }
    
    private func changePage(by value: Int) {
        let calendar = Calendar.current
        if let newPage = calendar.date(byAdding: .day, value: value, to: currentViewPage),
           newPage >= startDate && newPage <= endDate {
            currentViewPage = newPage
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
