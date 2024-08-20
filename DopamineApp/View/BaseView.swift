//
//  BaseView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/25/24.
//

import SwiftUI


struct BaseView: View {
    
    @Binding var modifiedCount: Int
    @Binding var unplannedCount: Int

    
    @State var title: String = ""
    @State var subtitle: String = ""
    
    @State private var goesToSetting: Bool = false
//    @State private var showTitleAndSubtitle: Bool = true
    

    
    var body: some View {
        NavigationStack {
            //  MainView
            VStack{
                
                Spacer()
                
//                Text(currentDateString())
                
//                if showTitleAndSubtitle && !title.isEmpty && !subtitle.isEmpty {
//                                    VStack {
//                                        Text(title)
//                                            .font(.system(size: 16, weight: .semibold))
//                                        Text(subtitle)
//                                            .font(.system(size: 16, weight: .medium))
//                                            .foregroundColor(.gray)
//                                    }
//                                }
                
                Text("무계획의 여행")
                    .font(.pretendardBold28)
                    .foregroundColor(.blue1)
                    .padding(.bottom, 30)
                
                HStack{
                      Text("무계획 여행")
                          .font(.pretendardSemiBold16)
                      Text("누적")
                          .font(.pretendardMedium16)
                      Text("\(unplannedCount)건")
                          .font(.pretendardMedium16)
  //                        .foregroundColor(.gray1)
                          .frame(width: 25, alignment: .trailing)

                  }
                  HStack{
                      Text("수정된 일정")
                          .font(.pretendardSemiBold16)
                      Text("누적")
                          .font(.pretendardMedium16)
                      Text("\(modifiedCount)건")
                          .font(.pretendardMedium16)
  //                        .foregroundColor(.gray1)
                          .frame(width: 25, alignment: .trailing)
                  }
                
                Spacer()

                
                ZStack{
                    Circle()
                        .fill(.white)
                        .stroke(Color.blue4, lineWidth: 6)
                        .frame(width: 250)
                    Image(systemName: "airplane.departure")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .foregroundColor(.blue1)
                }

                Spacer()
                
                


                
                NavigationLink(destination: TitleView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)) {
                                    Text("여행 시작하기")
                                        .frame(width: 300)
                                        .font(.pretendardBold18)
                                        .padding()
                                        .background(Color.blue1)
                                        .foregroundColor(.white)
                                        .cornerRadius(14)
                                }
//                .padding(.bottom, 50)
                .navigationTitle("")
                .navigationBarBackButtonHidden(true)
                .onTapGesture {
                    HapticManager.shared.mediumHaptic()
                }
                
                AppInfo
                .padding(.top, 10)
                .padding(.bottom, 20)


            }
        }
    }
    private func currentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: Date())
    }

}

private var AppInfo: some View {
    Button(action: {
        if let url = URL(string: "https://jigu1.notion.site/61491e311eba4793890149494fc46f09") {
            UIApplication.shared.open(url)
        }
    }) {
        HStack(spacing: 1) {
            Image(systemName: "info.circle")
                .foregroundStyle(Color.gray2)
                .font(.caption)
            Text("무계획의 계획 알아보기")
                .font(.pretendardRegular14)
                .foregroundStyle(Color.gray2)
                .underline() // 링크에 밑줄 추가
        }
    }
}

            

//#Preview {
//    BaseView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)
//}
