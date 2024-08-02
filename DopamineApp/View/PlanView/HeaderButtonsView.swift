//
//  HeaderButtonsView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/2/24.
//

import SwiftUI

enum HeaderButtonType {
    case set
    case plan
}

struct HeaderButtonsView: View {
    var type: HeaderButtonType
    var onBack: (() -> Void)?
    var onEnd: () -> Void
    
    var body: some View {
        
        HStack {
            if type == .set {
                Button(action: {
                    onBack?()
                }) {
                    Text("<뒤로")
                        .font(.pretendardBold18)
                        .foregroundColor(.gray)
                        .underline()
                }
            }
            Spacer()
            
            Button(action: onEnd, label: {
                Text("여행종료")
                    .font(.pretendardBold18)
                    .foregroundColor(.gray)
                    .underline()
            })
            
        }
        .padding(.horizontal)
        
    }
}

//#Preview {
//    HeaderButtonsView()
//}
