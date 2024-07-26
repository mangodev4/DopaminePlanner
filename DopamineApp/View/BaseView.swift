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
                .padding(.bottom, 30)
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
            ZStack{
                Circle()
                    .fill(.white)
                    .stroke(Color.blue, lineWidth: 3)
                    .frame(width: 250)
                Image(systemName: "airplane.departure")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            
            }
            //
            
        }
    }

#Preview {
    BaseView()
}
