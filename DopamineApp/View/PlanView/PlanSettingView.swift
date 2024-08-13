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
    @State var offset: CGSize = CGSize()
    @State private var keyboardHeight: CGFloat = 0
    @State private var isNavigatingToBase = false
    @State private var isNavigatingToPlan = false
    @State private var buttonHeight: CGFloat = 0
    
    
    
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
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HeaderButton
                        .padding(.horizontal, 45)
                        .padding(.vertical, 20)
                    
                    Spacer()
                    
                    
                    Text("일정을 입력해 주세요!")
                        .font(.pretendardMedium18)
                        .foregroundStyle(Color.gray2)
                    
                    ScrollViewReader { scrollViewProxy in
                        ScrollView {
                            todoListView
                                .onChange(of: focusedIndex) { newValue in
                                    withAnimation {
                                        if let newValue = newValue {
                                            scrollViewProxy.scrollTo(newValue, anchor: .top)
                                        }
                                    }
                                }
                        }
//                                .padding(.top, 5)
//                                .padding(.bottom, keyboardHeight)
                        .onAppear {
                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
                                    withAnimation {
                                        let keyboardHeight = keyboardFrame.height
                                        self.keyboardHeight = keyboardHeight

                                        if let focusedIndex = focusedIndex {
                                            scrollViewProxy.scrollTo(focusedIndex, anchor: .bottom)
                                        }
                                    }
                                }
                            }

                            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { _ in
                                withAnimation {
                                    self.keyboardHeight = 0
                                }
                            }
                        }
                        .onDisappear {
                            NotificationCenter.default.removeObserver(self)
                        }
                    }

                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                focusedIndex = 0
                            }
                        
                    }
                    
                    
                    Spacer()
                    
                    // MARK: 다음 버튼
                    Button(action: {
                        cleanUpTodoItems()
                        isNavigatingToPlan = true
                    }) {
                        Text("다음")
                            .frame(width: 300)
                            .font(.pretendardBold18)
                            .padding()
                            .background(isNextButtonEnabled ? Color.blue1 : Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(14)
                    }
                    //                        .frame(width: geometry.size.width)
                    .padding(.bottom, 10)
                    .zIndex(1)
                    .disabled(!isNextButtonEnabled)
                    
                    NavigationLink(
                        destination: PlanView(startDate: startDate, endDate: endDate, todoItems: $todoItems),
                        isActive: $isNavigatingToPlan,
                        label: { EmptyView() }
                    )
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                .contentShape(Rectangle())
                .onTapGesture {
                    hideKeyboard()
                }
                
                

                
            }
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
    }
    
    // MARK: - 빈 todo 항목 제거
    private func deleteTodo(at index: Int) {
        todoItems[currentSettingPage - 1].remove(at: index)
        if todoItems[currentSettingPage - 1].isEmpty {
            todoItems[currentSettingPage - 1].append("")
        }
    }
    
    // MARK: - 빈 todo index 삭제
    private func cleanUpTodoItems() {
        for dayIndex in todoItems.indices {
            todoItems[dayIndex].removeAll { $0.isEmpty }
        }
    }

    private var HeaderButton: some View {
            HStack {
                Button(action: {
                    if currentSettingPage > 1 {
                        currentSettingPage -= 1
                    }
                }, label: {
                    Image(systemName: "arrowtriangle.left.fill")
                        .foregroundColor((currentSettingPage <= 1) ? Color.gray : Color.blue1)
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
                    Image(systemName: "arrowtriangle.right.fill")
                        .foregroundColor((currentSettingPage >= numberOfDays) ? Color.gray : Color.blue1)
                        .font(.title)
                })
                .disabled(currentSettingPage >= numberOfDays)
                .opacity(currentSettingPage >= numberOfDays ? 0.5 : 1.0)

        }
    }
    
    private var todoListView: some View {
        VStack(spacing: 10) {
            ForEach(Array(todoItems[currentSettingPage - 1].prefix(10).enumerated()), id: \.offset) { index, item in
                todoItemView(for: index)
                    .id(index)
            }
        }
        .padding()
    }
    
    private var textChecker: some View {
        Text("\(todoItems[currentSettingPage - 1][focusedIndex ?? 0].count)/15")
            .font(.pretendardBold14)
            .foregroundStyle((focusedIndex != nil && todoItems[currentSettingPage - 1][focusedIndex!].count >= 15) ? Color.peach : Color.gray3)
            .padding(.trailing, 15)
    }
    
    private var isNextButtonEnabled: Bool {
        let areAllTodoItemsValid = todoItems.allSatisfy { dayItems in
            dayItems.contains { !$0.isEmpty }
        }
        return (startDate != nil && endDate != nil && startDate == endDate) || areAllTodoItemsValid
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
                },
                onDelete: {
                    deleteTodo(at: index)
                }
            )
            
            if focusedIndex != index {
                Button(action: {
                    deleteTodo(at: index)
                }, label: {
                    Image(systemName: "xmark")
                        .frame(width: 30, height: 30)
                        .font(.headline)
                        .foregroundColor(.blue3)
                })
                .padding(.trailing, 15)
            } else {
                textChecker
            }
        }
    }
    

    
    struct TodoItemView: View {
        @Binding var todo: String
        let index: Int
        @FocusState.Binding var focusedIndex: Int?
        var onCommit: () -> Void
        var onDelete: () -> Void
        
        @State private var isDeleting = false
        
        var body: some View {
            ZStack(alignment: .leading) {
                Rectangle()
                    .stroke(Color.gray2, lineWidth: 1)
                    .frame(width: 300, height: 60)
                    .background((focusedIndex == index) ? Color.gray4 : Color.white )
                    .opacity(0.5)
                
                
                TextField("할 일을 입력하세요", text: $todo, axis: .vertical)
                    .focused($focusedIndex, equals: index)
                    .font(.pretendardMedium16)
                    .foregroundColor(.gray1)
                    .padding(.leading, 20)
                    .frame(width: 280, height: 60, alignment: .leading)
                    .submitLabel(.next)
                    .onSubmit {
                        if isDeleting {
                            onDelete()
                        } else {
                            onCommit()
                        }
                    }
                    .onChange(of: todo) { newValue in
                        if newValue.hasSuffix("\n") {
                            todo.removeLast() // \n 제거
                            onCommit()
                        }
                        if newValue.count > 15 {
                            todo = String(newValue.prefix(15))
                        }
                        if todo.isEmpty {
                            isDeleting = true
                        } else {
                            isDeleting = false
                        }
                    }
                    .onTapGesture {
                        focusedIndex = index
                    }
            }
            
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

#Preview {
    PlanSettingView(startDate: Date(), endDate: Date())
}
