//
//  HeaderButtonsView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/2/24.
//

import SwiftUI

struct HeaderButtonsView: View {
    
    var onBack: () -> Void
    var onEnd: () -> Void
    
    var body: some View {
        
        HStack {
            Button(action: onBack, label: {
                Text("뒤로")
            })
            
            Spacer()
            
            Button(action: onBack, label: {
                Text("여행종료")
            })
            
        }
        
    }
}

//#Preview {
//    HeaderButtonsView()
//}
