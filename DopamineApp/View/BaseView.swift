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
                .font(.title)
            //      dateformatter
            HStack{
                Text("무계획 여행")
                Text("누적 00건")
            }
            HStack{
                Text("수정된 일정")
                Text("누적 00건")
            }
            .padding(.bottom, 50)
            
            Image(systemName: "airplane.departure")
                .font(.title)
            
            }
            //
            
        }
    }

#Preview {
    BaseView()
}
