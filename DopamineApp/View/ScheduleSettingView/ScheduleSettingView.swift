//
//  ScheduleSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/26/24.
//

import SwiftUI

struct ScheduleSettingView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isNavigating = false
   
    var body: some View {
        NavigationStack {
            VStack {
                Text(startDate == nil ? "여행 출발하는 날이 언제인가요?" : "여행 마지막 날이 언제인가요?")
                    .font(.pretendardBold24)
                    .padding(.bottom, 50)
                
                
                // 캘린더 뷰 띄울 위치
                CalenderView(month: Date(), startDate: $startDate, endDate: $endDate)
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 100)
                    

                Button(action: {
                                if startDate != nil && endDate != nil {
                                    isNavigating = true
                                }
                            }) {
                                Text("다음")
                                    .frame(width: 100)
                                    .font(.pretendardBold18)
                                    .padding()
                                    .background(startDate != nil && endDate != nil ? Color.blue1 : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                }
                .disabled(startDate == nil || endDate == nil)
                
                NavigationLink(
                               destination: PlanSettingView(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
                               isActive: $isNavigating,
                               label: { EmptyView() }
                           )
            }
        }
    }
    
    private func checkIfBothDatesAreSelected() {
        if startDate != nil && endDate != nil {
            print("Both startDate and endDate are selected")
            // Add any additional logic you need here
        }
    }
    
}


#Preview {
    ScheduleSettingView()
}
