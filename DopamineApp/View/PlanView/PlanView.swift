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
    @State private var focusedItem: (dayIndex: Int, itemIndex: Int)?

    @State private var editedItems: [[String]]

    
    @Binding var modifiedCount: Int
    @Binding var unplannedCount: Int

    @State private var isCheckedList: [[Bool]]
    @State private var isEdited: [[Bool]]



//    @FocusState private var focusedIndex: Int?

    
    //    var numberOfDays: Int {
    //        startDate.numberOfDays(to: endDate)
    //    }
    
    init(startDate: Date, endDate: Date, todoItems: Binding<[[String]]>, modifiedCount: Binding<Int>, unplannedCount: Binding<Int>) {
        self.startDate = startDate
        self.endDate = endDate
        self._todoItems = todoItems
        self._currentViewPage = State(initialValue: startDate)
        self._modifiedCount = modifiedCount
        self._unplannedCount = unplannedCount
        self._editedItems = State(initialValue: todoItems.wrappedValue)
        self._isCheckedList = State(initialValue: Array(repeating: Array(repeating: false, count: todoItems.wrappedValue.first?.count ?? 0), count: todoItems.wrappedValue.count))
        self._isEdited = State(initialValue: Array(repeating: Array(repeating: false, count: todoItems.wrappedValue.first?.count ?? 0), count: todoItems.wrappedValue.count))
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
                    HapticManager.shared.mediumHaptic()
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
            TripEndView(modifiedCount: $modifiedCount,unplannedCount: $unplannedCount)
                .onAppear {
                    modifiedCount = todoItems.flatMap { $0 }.count - modifiedCount
                    unplannedCount += 1

                }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
    
    private var headerView: some View {
        HStack {
            Spacer()
            
            Button(action: {
                HapticManager.shared.mediumHaptic()
                changePage(by: -1)
            }){
                Image(systemName: "chevron.left")
                    .foregroundColor(startDate < currentViewPage ? Color.blue3 : Color.gray)
                    .font(.title)
                
            }
            .disabled(startDate >= currentViewPage)

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
                HapticManager.shared.mediumHaptic()
                changePage(by: 1)
            }) {
                Image(systemName: "chevron.right")
                    .foregroundColor(currentViewPage < endDate ? Color.blue3 : Color.gray)
                    .font(.title)
                
            }
            .disabled(currentViewPage >= endDate)
            
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
                    get: { self.todoItems[dayIndex][index] },
                    set: { newValue in
                        self.todoItems[dayIndex][index] = newValue
                        if !self.isEdited[dayIndex][index] {
                            self.isEdited[dayIndex][index] = true
                            self.modifiedCount += 1
                        }
                    }
                ),
                isChecked: $isCheckedList[dayIndex][index],
                dayIndex: dayIndex,
                itemIndex: index,
                focusedItem: $focusedItem,
                onEditingChanged: { newDayIndex, newItemIndex in
                    if newDayIndex == nil && newItemIndex == nil {
                        focusedItem = nil
                    } else if let newDayIndex = newDayIndex, let newItemIndex = newItemIndex {
                        focusedItem = (newDayIndex, newItemIndex)
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
        @Binding var isChecked: Bool
        let dayIndex: Int
        let itemIndex: Int
        @Binding var focusedItem: (dayIndex: Int, itemIndex: Int)?
        let onEditingChanged: (Int?, Int?) -> Void

//        @State private var isEditing = false
//        @State private var editedTodo: String
        @FocusState private var isFocused: Bool
//        @State private var isChecked = false
        
        init(
            todo: Binding<String>,
            isChecked: Binding<Bool>,
            dayIndex: Int,
            itemIndex: Int,
            focusedItem: Binding<(dayIndex: Int, itemIndex: Int)?>,
            onEditingChanged: @escaping (Int?, Int?) -> Void) 
        {
            self._todo = todo
            self._isChecked = isChecked
            self.dayIndex = dayIndex
            self.itemIndex = itemIndex
            self._focusedItem = focusedItem
            self.onEditingChanged = onEditingChanged
        }
        
        var body: some View {
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .stroke(Color.gray2, lineWidth: 1)
                        .frame(width: 300, height: 60)
                        .background(focusedItem.map { $0 == (dayIndex, itemIndex) } == true ? Color.blue4 : Color.white )
                        .opacity(0.5)
                    
                    //  MARK: todoItem Edit Button
                    Button(action: {
                        HapticManager.shared.mediumHaptic()
                        if let focusedItem = focusedItem, focusedItem == (dayIndex, itemIndex) {
                            saveChanges()
                        } else {
                            HapticManager.shared.mediumHaptic()
                            onEditingChanged(dayIndex, itemIndex)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                isFocused = true
                            }
                        }
                    }) {
                        if let focusedItem = focusedItem, focusedItem == (dayIndex, itemIndex) {
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
                    //  MARK: todoItem Check Button
                    Button {
                        HapticManager.shared.mediumHaptic()
                        isChecked.toggle()
                    } label: {
                       Image(systemName: "checkmark.square.fill")
                            .font(.title2)
                            .foregroundColor(isChecked ? Color.blue5 : Color.gray3)
                    }
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.leading, 10)
                    .disabled(isFocused ==  true)

                    if let focusedItem = focusedItem, focusedItem == (dayIndex, itemIndex) {
                        TextField("새로운 계획을 입력하세요", text: $todo, onCommit: saveChanges)
                            .font(.pretendardMedium16)
                            .foregroundColor(Color.blue1)
                            .padding(.leading, 5)
                            .focused($isFocused)
                            .frame(width: 230, height: 60, alignment: .leading)
                            .submitLabel(.done)
                            .onChange(of: todo) { newValue in
                                if newValue.count > 15 {
                                    HapticManager.shared.heavyHaptic()
                                    todo = String(newValue.prefix(15))
                                    
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

                        //.padding(.trailing, 15)
                    }
                }
                .onChange(of: isFocused) { newValue in
                    if !newValue, let focusedItem = focusedItem, focusedItem == (dayIndex, itemIndex) {
                        saveChanges()
                    }
                }
            }

//            .onTapGesture {
//                isFocused = true
//            }
        }
        
        private func saveChanges() {
//            if editedTodo != todo {
//                todo = editedTodo
//            }
            onEditingChanged(nil, nil)
        }
    }
    func toggleCheck(for dayIndex: Int, at itemIndex: Int) {
        isCheckedList[dayIndex][itemIndex].toggle()
    }

    func isChecked(for dayIndex: Int, at itemIndex: Int) -> Bool {
        isCheckedList[dayIndex][itemIndex]
    }
    
//    func toggleCheck(for dayIndex: Int, at itemIndex: Int) {
//        isCheckedList[dayIndex][itemIndex].toggle()
//    }

}



//#Preview {
//    PlanView(        startDate: self.startDate,
//                     endDate: self.endDate,
//                     todoItems: $todoItems
//)
//}
