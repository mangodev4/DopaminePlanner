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
    @FocusState private var titleFocused: Bool
    @FocusState private var subtitleFocused: Bool
    
    @Binding var modifiedCount: Int
    @Binding var unplannedCount: Int
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderButtons
                
                Image(systemName: "airplane.departure")
                    .font(.system(size: 50, weight: .bold, design: .default))
                    .foregroundColor(.blue1)
                    .padding(.trailing, 200)
                    .padding(.vertical, 60)
                
                ZStack  {
                    Capsule()
                        .frame(width: 350, height: 60)
                        .foregroundColor(titleFocused ? Color.blue4 : Color.gray4)
                    HStack {
                        TextField("제목을 입력해 주세요.", text: $title, axis: .vertical)
                            .font(.pretendardBold18)
                            .foregroundColor(Color.gray1)
                            .frame(width: 300)
                            .onChange(of: title) { newValue in
                                if let newLineIndex = title.lastIndex(of: "\n") {
                                    title.remove(at: newLineIndex)
                                    print("submission!")
                                    subtitleFocused = true
                                } else if newValue.count > 15 {
                                    HapticManager.shared.heavyHaptic()
                                    title = String(newValue.prefix(15))
                                }
                                checkButtonState()
                            }
                            .focused($titleFocused)
                            .submitLabel(.next)
                            .onAppear{
                                titleFocused = true
                            }
                            .onSubmit {
                                titleFocused = false
                                subtitleFocused = true
                            }
                    }
                    if titleFocused {
                        textChecker(title.count)
                    }
                    
                    
                }
                ZStack  {
                    Capsule()
                        .frame(width: 350, height: 60)
                        .foregroundColor(subtitleFocused ? Color.blue4 : Color.gray4)
                    HStack {
                        TextField("부제를 입력해 주세요.", text: $subtitle)
                            .font(.pretendardMedium18)
                            .foregroundColor(Color.gray2)
                            .frame(width: 300)
                            .onChange(of: subtitle) { newValue in
                                if newValue.count > 15 {
                                    HapticManager.shared.heavyHaptic()
                                    subtitle = String(newValue.prefix(15))}
                                checkButtonState()
                            }
                            .focused($subtitleFocused)
                            .submitLabel(.next)
                            .submitScope()
                        
                        
                    }
                    if subtitleFocused {
                        textChecker(subtitle.count)
                    }
                    
                    
                }
                //                Spacer()
                
                
                NavigationLink(destination: ScheduleSettingView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)) {
                    Text("다음")
                        .frame(width: 300)
                        .font(.pretendardBold18)
                        .padding()
                        .background(isButtonEnabled ? Color.blue1 : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }
                .disabled(!isButtonEnabled)
                .padding(.top, 50)
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func checkButtonState() {
        isButtonEnabled = !title.isEmpty && !subtitle.isEmpty
    }
    
    private func textChecker(_ count: Int) -> some View {
        HStack {
            Spacer()
            
            Text("\(count)/15")
                .font(.pretendardRegular14)
                .foregroundColor(count >= 15 ? Color.peach : .gray2)
                .padding(.trailing, 25)
                .padding()
        }
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
                NavigationLink(destination: BaseView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)) {
                    HStack(spacing: 1) {
                        Image(systemName: "chevron.left")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("뒤로")
                            .font(.pretendardMedium16)
                            .foregroundColor(.gray)
                            .underline()
                            .baselineOffset(2)
                            .overlay {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: 100, height: 50)
                            }
                    }
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

//#Preview {
//    TitleView()
//}
