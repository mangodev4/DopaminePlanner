//
//  BaseView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/25/24.
//

import SwiftUI

struct BaseView: View {
    
    @State private var goesToSetting: Bool = false
    
    var body: some View {
        NavigationStack {
            //  MainView
            VStack{
                Text(currentDateString())
                    .font(.pretendardBold28)
                    .foregroundColor(.blue1)
                    .padding(.bottom, 30)
                
                HStack{
                    Text("무계획 여행")
                        .font(.pretendardSemiBold16)
                    Text("누적 00건")
                        .font(.pretendardMedium16)
                        .foregroundColor(.gray1)
                }
                HStack{
                    Text("수정된 일정")
                        .font(.pretendardSemiBold16)
                    Text("누적 00건")
                        .font(.pretendardMedium16)
                        .foregroundColor(.gray1)
                }
                .padding(.bottom, 50)
                ZStack{
                    Circle()
                        .fill(.white)
                        .stroke(Color.blue4, lineWidth: 6)
                        .frame(width: 250)
                    Image(systemName: "airplane.departure")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundColor(.blue1)
                }
                .padding(.bottom, 30)
                
                NavigationLink(destination: ScheduleSettingView()) {
                                    Text("여행 시작하기")
                                        .frame(width: 250)
                                        .font(.pretendardBold18)
                                        .padding()
                                        .background(Color.blue1)
                                        .foregroundColor(.white)
                                        .cornerRadius(14)
                                }
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
            }
        }
    }
    private func currentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: Date())
    }

}
            

#Preview {
    BaseView()
}
