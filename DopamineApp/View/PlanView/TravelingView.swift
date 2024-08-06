//
//  TravelingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/5/24.
//

//import SwiftUI
//
//struct TravelingView: View {
//    @State var title: String = ""
//    @State var subtitle: String = ""
//    
//    @State private var isNavigatingToBase = false
////    @State private var showTitleAndSubtitle: Bool = true
//    
//    var body: some View {
//        NavigationStack {
//            VStack{
//                Spacer()
//                
//                Text(currentDateString())
//                    .font(.pretendardBold28)
//                    .foregroundColor(.blue1)
//                    .padding(.bottom, 30)
//                
//                    
//                
//                HStack{
//                    Text("무계획 여행")
//                        .font(.pretendardSemiBold16)
//                    Text("누적 00건")
//                        .font(.pretendardMedium16)
//                        .foregroundColor(.gray1)
//                }
//                HStack{
//                    Text("수정된 일정")
//                        .font(.pretendardSemiBold16)
//                    Text("누적 00건")
//                        .font(.pretendardMedium16)
//                        .foregroundColor(.gray1)
//                }
//                .padding(.bottom, 50)
//                ZStack{
//                    Circle()
//                        .fill(.white)
//                        .stroke(Color.blue4, lineWidth: 6)
//                        .frame(width: 250)
//                    if !title.isEmpty && !subtitle.isEmpty {
//                                        VStack {
//                                            Text(title)
//                                                .font(.pretendardBold20)
//                                            Text(subtitle)
//                                                .font(.pretendardMedium18)
//                                                .foregroundColor(.gray)
//                                        }
//                                    }
//                }
//
//                Spacer()
//                
//                Text("도파민 수치 상승중!")
//                    .font(.pretendardMedium20)
//                
//                
//                Spacer()
//
//                
////                NavigationLink(destination: TitleView()) {
////                                    Text("여행 시작하기")
////                                        .frame(width: 250)
////                                        .font(.pretendardBold18)
////                                        .padding()
////                                        .background(Color.blue1)
////                                        .foregroundColor(.white)
////                                        .cornerRadius(14)
////                                }
//                
//            }
//
//        }
//        .navigationTitle("")
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button(action: {
//                    isNavigatingToBase = true
//                }) {
//                    Text("여행 종료")
//                        .font(.pretendardBold18)
//                        .foregroundColor(.gray)
//                        .underline()
//                }
//            }
//        }
//        .navigationDestination(isPresented: $isNavigatingToBase) {
//                BaseView()
//        }
//        .navigationBarBackButtonHidden()
//    }
//    private func currentDateString() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yy.MM.dd"
//        return dateFormatter.string(from: Date())
//    }
//
//}
//
//#Preview {
//    TravelingView()
//}
