//
//  PlanSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/2/24.
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
    
    //    @State private var startDate: Date? = nil
    //    @State private var endDate: Date? = nil
    @State private var isNavigatingToBase = false
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
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
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
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: BaseView(),
                        isActive: $isNavigatingToBase,
                        label: {
                            Button(action: {
                                isNavigatingToBase = true
                            }) {
                                Text("여행 종료")
                                    .font(.pretendardBold18)
                                    .foregroundColor(.gray)
                                    .underline()
                            }
                        }
                    )}
            }
        }
    }
}


//#Preview {
//    PlanSettingView(ㄴㅅ)
//}
