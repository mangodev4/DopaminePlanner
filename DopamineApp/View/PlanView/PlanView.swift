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
    @State private var isNavigatingToEnd = false
    @Binding var todoItems: [[String]]
    
//    var numberOfDays: Int {
//        startDate.numberOfDays(to: endDate)
//    }
    
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
            todoListView
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isNavigatingToEnd = true
                }) {
                    Text("여행 종료")
                        .font(.pretendardBold18)
                        .foregroundColor(.gray)
                        .underline()
                }
            }
        }
        .navigationDestination(isPresented: $isNavigatingToEnd) {
                TripEndView()
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
                    .foregroundColor(Color.blue3)
                    .font(.title)

            }
            Spacer()
            
            Text(currentViewPage, formatter: Self.dateFormatter)
                .font(.pretendardBold24)
                .foregroundStyle(Color.blue1)
            
            Spacer()
            
            Button(action: {
                changePage(by: 1)
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.blue3)
                    .font(.title)

            }
//            .disabled(currentViewPage >= numberOfDays)
//            .opacity(currentViewPage >= numberOfDays ? 0.2 : 1.0)

            
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
    
    //  MARK: TodoListView
    private var todoListView: some View {
        let dayIndex = Calendar.current.dateComponents([.day], from: startDate, to: currentViewPage).day ?? 0
        return VStack(alignment: .leading, spacing: 10) {
            ForEach(todoItems[dayIndex].indices, id: \.self) { index in
                HStack {
                    Text("\(index + 1).")
                        .font(.pretendardBold18)
                    Text(todoItems[dayIndex][index])
                        .font(.pretendardMedium16)
                }
            }
        }
        .padding()
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
//    PlanView(        startDate: self.startDate,
//                     endDate: self.endDate,
//                     todoItems: $todoItems
//)
//}
