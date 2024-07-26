//
//  BaseView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/25/24.
//

import SwiftUI

struct BaseView: View {
    var body: some View {
        
        //  MainView
        VStack{
            Text("00.00.00")
                .font(.pretendardBold28)
                .foregroundColor(.blue1)
                .padding(.bottom, 30)
            //      dateformatter
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
            
            Button("여행 시작하기") { }
            .buttonStyle(.borderedProminent)
            .font(.pretendardMedium18)
            .tint(.blue1)
            .padding(.top, 30)
            
            }
            //
            
        }
    }

#Preview {
    BaseView()
}
