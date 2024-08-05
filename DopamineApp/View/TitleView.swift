//
//  TitleView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/3/24.
//

import SwiftUI

struct TitleView: View {
    @State var title: String = ""
    @State var subtitle: String = ""
    @State private var isButtonEnabled: Bool = false
    @State private var isNavigatingToBase = false    
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderButtons
                Spacer()
                
                Image(systemName: "airplane.departure")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(.blue1)
                    .padding(.trailing, 200)
                
                Spacer()
                ZStack  {
                    Capsule()
                        .frame(width: 350, height: 60)
                        .foregroundColor(.gray4)
                    
                    TextField("제목을 입력해 주세요.", text: $title)
                        .font(.pretendardBold24)
                        .frame(width: 300, height: 0)
                        .onChange(of: title) {
                            checkButtonState()
                        }
                }
                ZStack  {
                    Capsule()
                        .frame(width: 350, height: 60)
                        .foregroundColor(.gray4)
                    
                    TextField("부제를 입력해 주세요.", text: $subtitle)
                        .font(.pretendardBold24)
                        .frame(width: 300)
                        .onChange(of: subtitle) {
                            checkButtonState()
                        }
                }
                Spacer()
                
                
                NavigationLink(destination: ScheduleSettingView()) {
                    Text("다음")
                        .frame(width: 300)
                        .font(.pretendardBold18)
                        .padding()
                        .background(isButtonEnabled ? Color.blue1 : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .disabled(!isButtonEnabled)
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func checkButtonState() {
        isButtonEnabled = !title.isEmpty && !subtitle.isEmpty
    }
    
    // MARK: 헤더 버튼 뷰
    private var HeaderButtons: some View {
        HStack {
            Button(action: {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = windowScene.windows.first {
                        window.rootViewController?.dismiss(animated: true, completion: nil)
                    }
                }
            }) {
                NavigationLink(destination: BaseView()) {
                    Text("<뒤로")
                        .font(.pretendardBold18)
                        .foregroundColor(.gray)
                        .underline()
                }

            }
            .padding(.leading, 10)
            
            
            Spacer()
            
//            Button(action: {
//                isNavigatingToBase = true
//            }) {
//                NavigationLink(destination: BaseView()) {
//                    Text("여행 종료")
//                        .font(.pretendardBold18)
//                        .foregroundColor(.gray)
//                        .underline()
//                }
//            }
//            .padding(.trailing, 10)
        }
        .padding()
    }
    
}

#Preview {
    TitleView()
}
