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
    @State var offset: CGSize = CGSize()
//    @State private var isNavigating = false
    @State private var isNavigatingToBase = false
    @State private var isNavigatingToPlan = false
    @State private var isNavigatingToTitle = false

   
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
            VStack {
                
//                Spacer()
                
                Text("여행 기간을 선택해 주세요.")
                    .font(.pretendardMedium24)
                    .padding(.top, 90)
                    .frame(width: geometry.size.width)

                
                
                //                Text(startDate == nil ? "여행 출발하는 날이 언제인가요?" : "여행 마지막 날이 언제인가요?")
                //                    .font(.pretendardBold24)
                
                Spacer()
                
                
                // 캘린더 뷰
                CalenderView(month: Date(), startDate: $startDate, endDate: $endDate)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 10)
                    .padding(.top, 10)
                
                Spacer()
                Button(action: {
                    if startDate != nil && endDate != nil {
                        isNavigatingToPlan = true
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
                .frame(width: geometry.size.width)
                .padding(.bottom, 30)

                
                NavigationLink(
                    destination: PlanSettingView(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
                    isActive: $isNavigatingToPlan,
                    label: { EmptyView() }
                )
//                Spacer()
            }
        }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isNavigatingToTitle = true
                }) {
                    Text("<뒤로")
                        .font(.pretendardBold18)
                        .foregroundColor(.gray)
                        .underline()
                }
            }
            
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
        .navigationDestination(isPresented: $isNavigatingToTitle) {
                TitleView()
        }
        .navigationDestination(isPresented: $isNavigatingToBase) {
                BaseView()
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func checkIfBothDatesAreSelected() {
        if startDate != nil && endDate != nil {
            print("Both startDate and endDate are selected")
        }
    }
    
    }





#Preview {
    ScheduleSettingView()
}
