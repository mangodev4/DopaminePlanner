//
//  PlanSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/2/24.
//

import SwiftUI

struct PlanSettingView: View {
    @State private var startDate: Date? = nil
    @State private var endDate: Date? = nil
    @State private var isNavigatingToPlan = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("일정을 입력해 주세요!")
                //        Text("DAY \())")
                
                Spacer()
                
                Button(action: {
                    isNavigatingToPlan = true
                }) {
                    Text("다음")
                        .frame(width: 300)
                        .font(.pretendardBold18)
                        .padding()
                        .background(Color.blue1)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                
                NavigationLink(
                               destination: PlanView(startDate: startDate ?? Date(), endDate: endDate ?? Date()),
                               isActive: $isNavigatingToPlan,
                               label: { EmptyView() }
                           )

                
            }
        }
    }
}

#Preview {
    PlanSettingView()
}
