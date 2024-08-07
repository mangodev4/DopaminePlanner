//
//  PlanSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 8/2/24.
//

import SwiftUI

struct PlanSettingView: View {
    var startDate: Date
    var endDate: Date
    
    @State private var currentSettingPage: Int = 1
    @State private var todoItems: [[String]] = []
    @FocusState private var focusedIndex: Int?
    @State private var isNavigatingToBase = false
    @State private var isNavigatingToPlan = false
    
//    @StateObject var keyboardManager = KeyboardManager()

    
    
    var numberOfDays: Int {
        max(0,Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0) + 1
    }
    
    
    init(startDate: Date, endDate: Date) {
        self.startDate = startDate
        self.endDate = endDate
        let days = max(1, Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0) + 1
        _todoItems = State(initialValue: Array(repeating: [""], count: days))
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                HStack {
                    Button(action: {
                        if currentSettingPage > 1 {
                            currentSettingPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.blue3)
                            .font(.title)
                    })
                    .disabled(currentSettingPage <= 1)
                    .opacity(currentSettingPage <= 1 ? 0.5 : 1.0)
                    
                    Spacer()
                    
                    Text("DAY \(currentSettingPage)")
                        .font(.system(size: 35).bold())
                        .foregroundStyle(Color.blue1)
                    
                    
                    Spacer()
                    
                    Button(action: {
                        if currentSettingPage < numberOfDays {
                            currentSettingPage += 1
                        }
                    }, label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.blue3)
                            .font(.title)
                    })
                    .disabled(currentSettingPage >= numberOfDays)
                    .opacity(currentSettingPage >= numberOfDays ? 0.2 : 1.0)
                    
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 25)
                
                Spacer()
                
                
                Text("일정을 입력해 주세요!")
                    .font(.pretendardBold20)
                
                
                ScrollView {
                    todoListView
                }
                .padding(.top, 5)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    focusedIndex = 0
                }
            }
            
            
            
            Spacer()
            //            HStack {
            //                Button(action: {
            //                    if currentSettingPage > 1 {
            //                        currentSettingPage -= 1
            //                    }
            //                }) {
            //                    Text("이전")
            //                        .frame(width: 100)
            //                        .font(.pretendardBold18)
            //                        .padding()
            //                        .background(Color.blue1)
            //                        .foregroundColor(.white)
            //                        .cornerRadius(14)
            //                }
            //                .disabled(currentSettingPage <= 1)
            //                .opacity(currentSettingPage <= 1 ? 0.5 : 1.0)
            //
            //
            //
            //                Button(action: {
            //                    if currentSettingPage < numberOfDays {
            //                        currentSettingPage += 1
            //                    }
            //                }) {
            //                    Text("다음")
            //                        .frame(width: 200)
            //                        .font(.pretendardBold18)
            //                        .padding()
            //                        .background(Color.blue1)
            //                        .foregroundColor(.white)
            //                        .cornerRadius(14)
            //                }
            //                .disabled(currentSettingPage >= numberOfDays)
            //                .opacity(currentSettingPage >= numberOfDays ? 0.5 : 1.0)
            //            }
            
            Button(action: {
                isNavigatingToPlan = true
            }) {
                Text("다음")
                    .frame(width: 300)
                    .font(.pretendardBold18)
                    .padding()
                    .background(Color.blue1)
                    .foregroundColor(.white)
                    .cornerRadius(14)
            }
            .padding(.bottom, 30)
            
            NavigationLink(
                destination: PlanView(startDate: startDate, endDate: endDate, todoItems: $todoItems),
                isActive: $isNavigatingToPlan,
                label: { EmptyView() }
            )
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isNavigatingToBase = true
                }) {
                    Text("여행 종료")
                        .font(.pretendardBold18)
                        .foregroundColor(.gray)
                        .underline()
                }
            }
        }
        .navigationDestination(isPresented: $isNavigatingToBase) {
            BaseView()
        }
        .navigationBarBackButtonHidden(true)
//        .onChange(of: keyboardManager.isKeyboardDissmissed) { isDismissed in
//            if isDismissed {
//                focusedIndex = nil
//            }
//        }
    }
    
    private func deleteTodo(at index: Int) {
        todoItems[currentSettingPage - 1].remove(at: index)
        if todoItems[currentSettingPage - 1].isEmpty {
            todoItems[currentSettingPage - 1].append("")
        }
    }
    
    
    private var todoListView: some View {
        VStack(spacing: 10) {
            ForEach(Array(todoItems[currentSettingPage - 1].enumerated()), id: \.offset) { index, item in
                todoItemView(for: index)
            }
        }
        .padding()
    }
    
    private var textChecker: some View {
        Text("\(focusedIndex ?? 0 + 1)/16")
                .font(.pretendardBold14)
                .foregroundStyle(Color.gray3)
                .padding(.trailing, 15)
        }
    
    
    
    private func todoItemView(for index: Int) -> some View {
        ZStack(alignment: .trailing) {
            TodoItemView(
                todo: Binding(
                    get: { index < todoItems[currentSettingPage - 1].count ? todoItems[currentSettingPage - 1][index] : "" },
                    set: { newValue in
                        if index < todoItems[currentSettingPage - 1].count {
                            todoItems[currentSettingPage - 1][index] = newValue
                        } else if !newValue.isEmpty {
                            todoItems[currentSettingPage - 1].append(newValue)
                        }
                    }
                ),
                index: index,
                focusedIndex: $focusedIndex,
                onCommit: {
                    if index == todoItems[currentSettingPage - 1].count - 1 && !todoItems[currentSettingPage - 1][index].isEmpty {
                        todoItems[currentSettingPage - 1].append("")
                    }
                    focusedIndex = index + 1
                }
            )
            
            if focusedIndex != index {
                Button(action: {
                    deleteTodo(at: index)
                }, label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundColor(.blue3)
                })
                .padding(.trailing, 15)
            } else {
                textChecker
            }
        }
    }
    
//    //  MARK: Keyboard 내려감 방지
//    private func hideKeyboard() {
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//    }

    
    
    struct TodoItemView: View {
        @Binding var todo: String
        let index: Int
        @FocusState.Binding var focusedIndex: Int?
        var onCommit: () -> Void
        
        var body: some View {
            ZStack(alignment: .leading) {
                Rectangle()
                    .stroke(Color.gray2, lineWidth: 1)
                    .frame(width: 300, height: 60)
                    .opacity(0.5)
                
                
                TextField("할 일을 입력하세요", text: $todo)
                    .focused($focusedIndex, equals: index)
                    .font(.pretendardBold20)
                    .foregroundColor(.gray1)
                    .padding(.leading, 20)
                    .frame(width: 280, height: 60, alignment: .leading)
                    .submitLabel(.next)
                    .onSubmit{
                        onCommit()
                    }
            }
            .onTapGesture {
                focusedIndex = index
            }
        }
    }
}

#Preview {
    PlanSettingView(startDate: Date(), endDate: Date())
}
