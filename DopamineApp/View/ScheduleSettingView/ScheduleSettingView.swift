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
    @State private var isNavigatingToBase = false
    @State private var isNavigatingToPlan = false

   
    var body: some View {
        NavigationStack {
            VStack {
                HeaderButtons
                
                Spacer()
                
                Text(startDate == nil ? "여행 출발하는 날이 언제인가요?" : "여행 마지막 날이 언제인가요?")
                    .font(.pretendardBold24)
//                    .padding(.vertical, 30)
                
                Spacer()

                
                // 캘린더 뷰
                CalenderView(month: Date(), startDate: $startDate, endDate: $endDate)
                    .padding(.top, 20)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 100)
                    
                Spacer()
                
                Button(action: {
                                if startDate != nil && endDate != nil {
                                    isNavigating = true
                                }
                            }) {
                                Text("다음")
                                    .frame(width: 300)
                                    .font(.pretendardBold18)
                                    .padding()
                                    .background(startDate != nil && endDate != nil ? Color.blue1 : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(14)
                }
                .disabled(startDate == nil || endDate == nil)
                
                NavigationLink(
                               destination: PlanView(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
                               isActive: $isNavigating,
                               label: { EmptyView() }
                           )
                Spacer()
            }
        }
    }
    
    private func checkIfBothDatesAreSelected() {
        if startDate != nil && endDate != nil {
            print("Both startDate and endDate are selected")
            // Add any additional logic you need here
        }
    }
    
    // MARK: 헤더 버튼 뷰
    private var HeaderButtons: some View {
        HStack {
            Button(action: {
                if let window = UIApplication.shared.windows.first {
                    window.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }) {
                Text("<뒤로")
                    .font(.pretendardBold18)
                    .foregroundColor(.gray)
                    .underline()
            }
            .padding(.leading, 10)
            
            Spacer()
            
            Button(action: {
                isNavigatingToBase = true
            }) {
                Text("여행 종료")
                    .font(.pretendardBold18)
                    .foregroundColor(.gray)
                    .underline()
            }
            .padding(.trailing, 10)
        }
        .padding()
    }
    
}




#Preview {
    ScheduleSettingView()
}
