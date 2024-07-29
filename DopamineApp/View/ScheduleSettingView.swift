//
//  ScheduleSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/26/24.
//

import SwiftUI

struct ScheduleSettingView: View {
    @State private var isStartDate = true

    var body: some View {
        NavigationStack {
            VStack {
                Text(isStartDate ? "여행 출발하는 날이 언제인가요?" : "여행 마지막 날이 언제인가요?")
                    .font(.pretendardBold18)
                    .padding(20)
                
                
                // 캘린더 뷰 띄울 위치
                CalenderView(month: Date())
                
                Button(action: {
                    isStartDate.toggle()
                }) {
                    Text("여행날짜 클릭")
                        .font(.system(size: 18, weight: .bold, design: .default))
                        .padding()
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                }
                NavigationLink(destination: PlanSettingView()) {
                                   Text("다음")
                                       .font(.system(size: 18, weight: .bold, design: .default))
                                       .padding()
                                       .background(Color.blue1)
                                       .foregroundColor(.white)
                                       .cornerRadius(10)
                               }
            }
            .padding()
        }
    }
}


#Preview {
    ScheduleSettingView()
}
