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
                        .font(.pretendardBold18)
                        .foregroundColor(.gray)
                        .underline()
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
                    .foregroundColor(Color.blue3)
                    .font(.title)
                
            }
            Spacer()
            
            Text(currentViewPage, formatter: Self.dateFormatter)
                .font(.pretendardBold24)
                .foregroundStyle(Color.blue1)
            
            Spacer()
            
            Button(action: {
                changePage(by: 1)
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.blue3)
                    .font(.title)
                
            }
            //            .disabled(currentViewPage >= numberOfDays)
            //            .opacity(currentViewPage >= numberOfDays ? 0.2 : 1.0)
            
            
            Spacer()
        }
        .padding(.top, 10)
    }
    
    
    private var pageView: some View {
        VStack {
            Text("할 일 목록")
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
                index: index
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
        @FocusState private var isFocused: Bool

        @State private var isEditing = false
        @State private var editedTodo: String
        
        init(todo: Binding<String>, index: Int) {
            self._todo = todo
            self.index = index
            self._editedTodo = State(initialValue: todo.wrappedValue)
        }
        
        var body: some View {
            ZStack(alignment: .leading) {
                Rectangle()
                    .stroke(Color.gray2, lineWidth: 1)
                    .frame(width: 300, height: 60)
                    .background(isFocused ? Color.gray4 : Color.white )
                    .opacity(0.5)
                
                HStack {
                if isEditing {
                    TextField("할 일을 입력하세요", text: $editedTodo, onCommit: saveChanges)
                        .font(.pretendardMedium16)
                        .foregroundColor(.gray1)
                        .padding(.leading, 20)
                        .frame(width: 280, height: 60, alignment: .leading)
                        .submitLabel(.done)
                } else {
                    Text(todo)
                        .font(.pretendardMedium16)
                        .foregroundColor(.gray1)
                        .padding(.leading, 20)
                        .frame(width: 280, height: 60, alignment: .leading)
                    //                    .submitLabel(.next)
                    //                    .onSubmit{
                    //                        onCommit()
                    //                    }
                    //                    .onChange(of: todo) { newValue in
                    //                        if newValue.count > 15 {
                    //                            todo = String(newValue.prefix(15))
                    //                        }
                    //                    }
                }
                
                
                    
                    Button(action: {
                        if isEditing {
                            saveChanges()
                        } else {
                            isEditing = true
                            isFocused = true
                        }
                    }) {
                        if isEditing {
                            Text("저장")
                                .font(.pretendardMedium16)
                                .foregroundColor(.blue3)
                        } else {
                            Image(systemName: "arrow.2.squarepath")
                                .font(.headline)
                                .foregroundColor(.blue3)
                        }
                    }
                    .padding(.trailing, 15)
                }
            }
//            .onTapGesture {
//                isFocused = true
//            }
        }
        
        private func saveChanges() {
            todo = editedTodo
            isEditing = false
            isFocused = false
        }
    }
}



//#Preview {
//    PlanView(        startDate: self.startDate,
//                     endDate: self.endDate,
//                     todoItems: $todoItems
//)
//}
