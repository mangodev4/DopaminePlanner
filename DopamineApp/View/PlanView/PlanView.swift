//
//  PlanSettingView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/27/24.
//

import SwiftUI

struct PlanView: View {
    var startDate: Date
    var endDate: Date
    
    @State private var currentViewPage: Date
    @State private var isNavigatingToEnd = false
    @Binding var todoItems: [[String]]
    
    @State private var showAlert = false
    @State private var focusedIndex: Int?


//    @FocusState private var focusedIndex: Int?

    
    //    var numberOfDays: Int {
    //        startDate.numberOfDays(to: endDate)
    //    }
    
    init(startDate: Date, endDate: Date, todoItems: Binding<[[String]]>) {
        self.startDate = startDate
        self.endDate = endDate
        self._todoItems = todoItems
        self._currentViewPage = State(initialValue: startDate)
    }
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                pageView
                
                ScrollView {
                    todoListView
                }
                Spacer()
            }
            .zIndex(1)
                
                if showAlert {
                        Color.black
                            .opacity(0.5)
                            .ignoresSafeArea()
                            .zIndex(2)
                        AlertView(showAlert: $showAlert, isNavigatingToEnd: $isNavigatingToEnd)
                            .transition(.scale)
                            .zIndex(3)
                }
                
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showAlert = true
                }) {
                    Text("여행 종료")
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
        .navigationDestination(isPresented: $isNavigatingToEnd) {
            TripEndView()
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
    
    private var headerView: some View {
        HStack {
            Spacer()
            
            Button(action: {
                changePage(by: -1)
            }){
                Image(systemName: "chevron.left")
                    .foregroundColor(startDate < currentViewPage ? Color.blue3 : Color.gray)
                    .font(.title)
                
            }
            .disabled(startDate > currentViewPage)

            Spacer()
            
            Text(currentViewPage, formatter: Self.dateFormatter)
                .font(.pretendardBold24)
                .foregroundStyle(Color.blue1)
                .overlay {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 150, height: 30)
                }
            
            Spacer()
            
            Button(action: {
                changePage(by: 1)
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(currentViewPage < endDate ? Color.blue3 : Color.gray)
                    .font(.title)
                
            }
            .disabled(currentViewPage > endDate)
            
            Spacer()
        }
        .padding(.top, 10)
    }
    
    private var pageView: some View {
        VStack {
            Text("오늘의 계획")
                .font(.pretendardMedium18)
                .foregroundStyle(Color.gray2)
        }
        .onAppear{
            currentViewPage = startDate
        }
        .padding(.top, 5)
    }
    
    //  MARK: TodoListView
    private var todoListView: some View {
        let dayIndex = Calendar.current.dateComponents([.day], from: startDate, to: currentViewPage).day ?? 0
        return VStack(alignment: .leading, spacing: 10) {
            ForEach(todoItems[dayIndex].indices, id: \.self) { index in
                todoItemView(for: index, in: dayIndex)
            }
        }
        .padding()
    }
    
    private func todoItemView(for index: Int, in dayIndex: Int) -> some View {
        ZStack(alignment: .trailing) {
            TodoItemView(
                todo: Binding(
                    get: { index < todoItems[dayIndex].count ? todoItems[dayIndex][index] : "" },
                    set: { newValue in
                        if index < todoItems[dayIndex].count {
                            todoItems[dayIndex][index] = newValue
                        } else if !newValue.isEmpty {
                            todoItems[dayIndex].append(newValue)
                        }
                    }
                ),
                index: index,
                focusedIndex: focusedIndex,
                onEditingChanged: { newIndex in
                    if newIndex == nil {
                        focusedIndex = nil
                    } else {
                        focusedIndex = newIndex
                    }
                }
            )

            
//            Button(action: {
//                //                    deleteTodo(at: index)
//            }, label: {
//                Image(systemName: "arrow.2.squarepath")
//                    .font(.headline)
//                    .foregroundColor(.blue3)
//            })
//            .padding(.trailing, 15)
        }
    }
    
    private func changePage(by value: Int) {
        let calendar = Calendar.current
        if let newPage = calendar.date(byAdding: .day, value: value, to: currentViewPage),
           newPage >= startDate && newPage <= endDate {
            currentViewPage = newPage
        }
    }
    
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    struct TodoItemView: View {
        @Binding var todo: String
        let index: Int
        let focusedIndex: Int?
        let onEditingChanged: (Int?) -> Void

//        @State private var isEditing = false
        @State private var editedTodo: String
        @FocusState private var isFocused: Bool
        @State private var isChecked = false
        
        init(todo: Binding<String>, index: Int, focusedIndex: Int?, onEditingChanged: @escaping (Int?) -> Void) {
            self._todo = todo
            self.index = index
            self._editedTodo = State(initialValue: todo.wrappedValue)
            self.focusedIndex = focusedIndex
            self.onEditingChanged = onEditingChanged
        }
        
        var body: some View {
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .stroke(Color.gray2, lineWidth: 1)
                        .frame(width: 300, height: 60)
                        .background(focusedIndex == index ? Color.gray4 : Color.white )
                        .opacity(0.5)
                    
                    //  MARK: todoItem Edit Button
                    Button(action: {
                        if focusedIndex == index {
                            saveChanges()
                        } else {
                            onEditingChanged(index)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isFocused = true
                            }
                        }
                    }) {
                        if focusedIndex == index {
                            Text("저장")
                                .font(.pretendardMedium16)
                                .foregroundColor(.blue3)
                        } else {
                            Image(systemName: "arrow.2.squarepath")
                                .font(.headline)
                                .foregroundColor(isChecked ? Color.gray3 : Color.blue3)
                        }
                    }
                    .frame(width: 40, height: 50, alignment: .leading)
                    .disabled(isChecked == true)

                }
                HStack(spacing: 0) {
                    Button {
                        isChecked.toggle()
                    } label: {
                       Image(systemName: "checkmark.square.fill")
                            .font(.title2)
                            .foregroundColor(isChecked ? Color.blue5 : Color.gray3)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.leading, 10)
                    
                    if focusedIndex == index {
                        TextField("새로운 계획을 입력하세요", text: $editedTodo, onCommit: saveChanges)
                            .font(.pretendardMedium16)
                            .foregroundColor(.gray1)
                            .padding(.leading, 5)
                            .focused($isFocused)
                            .frame(width: 230, height: 60, alignment: .leading)
                            .submitLabel(.done)
                            .onChange(of: editedTodo) { newValue in
                                if newValue.count > 15 {
                                    editedTodo = String(newValue.prefix(15))
                                }
                            }
                    } else {
                        Text(todo)
                            .font(.pretendardMedium16)
                            .foregroundColor(.gray1)
                            .strikethrough(isChecked, color: Color.peach)
                            .padding(.leading, 5)
                            .frame(width: 230, height: 60, alignment: .leading)
                        //                    .submitLabel(.next)
                        //                    .onSubmit{
                        //                        onCommit()
                        //                    }
                            .onChange(of: editedTodo) { newValue in
                                if newValue != todo {
                                    editedTodo = newValue
                                }
                            }
                        
                        //.padding(.trailing, 15)
                    }
                }
                .onChange(of: isFocused) { newValue in
                    if !newValue && focusedIndex == index {
                        saveChanges()
                    }
                }
            }

//            .onTapGesture {
//                isFocused = true
//            }
        }
        
        private func saveChanges() {
            if editedTodo != todo {
                todo = editedTodo
            }
            onEditingChanged(nil)
        }
    }
}



//#Preview {
//    PlanView(        startDate: self.startDate,
//                     endDate: self.endDate,
//                     todoItems: $todoItems
//)
//}
