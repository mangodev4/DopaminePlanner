//
//  AlertView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/11/24.
//

import SwiftUI

struct AlertView: View {
    @Binding var showAlert: Bool
    @Binding var isNavigatingToEnd: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
            
            VStack(spacing: 0) {
                
                textBox
                    .padding(.top, 32)
                    .padding(.bottom, 28)
                Divider()
                buttonBox
                
            }
        }
        .frame(width: 282, height: 172)
    }
}

extension AlertView {
    private var textBox: some View {
        VStack(spacing: 0) {
            Text("여행을 종료하시겠어요?")
                .font(.pretendardBold18)
                .foregroundStyle(.black)
                .padding(.bottom, 12)
            Text("지금까지 작성된 계획은 저장되지 않아요.")
                .font(.pretendardMedium16)
                .foregroundStyle(Color.gray2)
        }
    }
    private var buttonBox: some View {
        HStack {
            Spacer()
            cancelButton
            Divider()
            endButton
            Spacer()
        }
    }
    
    
    private var cancelButton: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.white)
            .overlay(
                VStack {
                    Spacer()
                    Text("취소하기")
                        .font(.pretendardMedium18)
                        .foregroundStyle(Color.gray2)
                    Spacer()
                }
            )
            .onTapGesture {
                HapticManager.shared.mediumHaptic()
                showAlert = false
            }
        
    }
    
    private var endButton: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.white)
            .overlay(
                VStack {
                    Spacer()
                    Text("종료하기")
                        .font(.pretendardBold18)
                        .foregroundStyle(Color.blue1)
                    Spacer()
                }
            )
            .onTapGesture {
                HapticManager.shared.mediumHaptic()
                showAlert = false
                isNavigatingToEnd = true
            }
    }
    
}

//#Preview {
//    AlertView(showAlert: showAlert, isNavigatingToEnd: isNavigatingToEnd)
//}
