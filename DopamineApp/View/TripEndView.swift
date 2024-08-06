//
//  TripEndView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/7/24.
//

import SwiftUI

struct TripEndView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("모든 여행이 종료되었어요!")
                Text("여행 내용을 저장할까요?")
            }
            .padding()
            .font(.pretendardBold20)
            .padding(.bottom, 50)
            
            
            Spacer()
            
            
            Image(systemName: "checkmark.circle")
                .font(.system(size: 90, weight: .regular, design: .default))
                .foregroundColor(.blue1)
                .padding(.bottom, 50)
//            Text("여행 종료")
//                .font(.pretendardBold20)
//                .foregroundStyle(Color.blue1)

            
            
            Button(action: {
            }, label: {
                ZStack {
                    Capsule()
                        .stroke(Color.gray2, lineWidth: 1)
                        .frame(width: 100, height: 40)
                    
                    Text("저장하기")
                        .foregroundStyle(Color.blue1)
                    
                }
            })
            
            Spacer()
            
            NavigationLink(destination: BaseView()) {
                Text("처음으로")
                    .frame(width: 300)
                    .font(.pretendardBold18)
                    .padding()
                    .background(Color.blue1)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.bottom, 30)
        }
    }
}

#Preview {
    TripEndView()
}
