//
//  TripEndView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/7/24.
//

import SwiftUI

struct TripEndView: View {
    
    @Binding var modifiedCount: Int
    @Binding var unplannedCount: Int
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Text("모든 여행이 종료되었어요!")
//                    Text("여행 내용을 저장할까요?")
                }
                .padding()
                .font(.pretendardBold20)
                .padding(.bottom, 50)
                
                
                Spacer()
                
                
                Image(systemName: "checkmark.circle")
                    .font(.system(size: 90, weight: .regular, design: .default))
                    .foregroundColor(.blue1)
                    .padding(.bottom, 50)
                
                Spacer()
                
                NavigationLink(destination: BaseView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)) {
                    Text("확인")
                        .frame(width: 300)
                        .font(.pretendardBold18)
                        .padding()
                        .background(Color.blue1)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .padding(.bottom, 30)
                .onTapGesture {
                    HapticManager.shared.mediumHaptic()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    TripEndView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)
//}
