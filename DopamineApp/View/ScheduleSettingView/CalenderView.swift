//
//  CalenderView.swift
//  DopamineApp
//
//  Created by Yujin Son on 7/26/24.
//

import SwiftUI

struct CalenderView: View {
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    @Binding var startDate: Date?
    @Binding var endDate: Date?
  
  var body: some View {
    VStack {
      headerView
            .background(Color.clear)
            .zIndex(1)
      calendarGridView
    }
    .gesture(
      DragGesture()
        .onChanged { gesture in
          self.offset = gesture.translation
        }
        .onEnded { gesture in
          if gesture.translation.width < -100 {
            changeMonth(by: 1)
          } else if gesture.translation.width > 100 {
            changeMonth(by: -1)
          }
          self.offset = CGSize()
        }
    )
  }
  
  // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                Button(action: {
                    changeMonth(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.blue3)
                        .font(.title3)
                        .padding(.trailing, 20)
                        .padding(.bottom, 10)
                }
                Text(month, formatter: Self.dateFormatter)
                    .frame(width: 220)
                    .font(.pretendardSemiBold28)
                    .padding(.bottom)
                Button(action: {
                    changeMonth(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue3)
                        .font(.title3)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                }
            }
            .padding(.bottom, 10)
            
            HStack {
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .foregroundColor(.gray2)
                        .font(.pretendardMedium18)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 5)
        }
    }
  
  // MARK: - 날짜 그리드 뷰
  private var calendarGridView: some View {
    let daysInMonth: Int = numberOfDays(in: month)
    let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 1
    let today = Calendar.current.startOfDay(for: Date())


    return VStack {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7),spacing: 3) {
            ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                if index < firstWeekday {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.clear)
                } else {
                    let date = getDate(for: index - firstWeekday)
                    let day = index - firstWeekday + 1
                    let clicked = clickedDates.contains(date)
                    let isInRange = isDateInRange(date)
                    let isStartOrEndDate = date == startDate || date == endDate
                    let isToday = Calendar.current.isDate(date, inSameDayAs: today)

                    
                    ZStack {
                        if isInRange {
                            Circle()
                                .frame(width: 36, height: 36)
                                .foregroundColor(.blue)
                                .opacity(0.2)
                        }
                        
                        if isToday {
                            Circle()
                                .stroke(Color.blue1, lineWidth: 1)
                                .frame(width: 36, height: 36)
                                                }
                        
                        CellView(day: day, clicked: clicked)
                            .background(
                                Circle()
                                    .frame(width: 36, height: 36)
                                    .foregroundColor(isStartOrEndDate ? Color.blue3 : Color.clear)
//                                    .scaleEffect(4)
                            )
                            .onTapGesture {
                                if let start = startDate, let end = endDate {
                                    resetDates()
                                    startDate = date
                                } else if startDate == nil {
                                    startDate = date
                                } else if endDate == nil {
                                    if date < startDate! {
                                        resetDates()
                                        startDate = date
                                    } else {
                                        endDate = date
                                    }
                                    }
                                if clicked {
                                    clickedDates.remove(date)
                                } else {
                                    clickedDates.insert(date)
                                }
                            }
                            .padding(10)
                    }
                }
            }
        }
    }
  }


private func isDateInRange(_ date: Date) -> Bool {
    guard let start = startDate, let end = endDate else {
        return false
    }
    return date >= start && date <= end
}
    private func resetDates() {
        clickedDates.removeAll()
        startDate = nil
        endDate = nil
    }
}


// MARK: - 일자 셀 뷰
private struct CellView: View {
  var day: Int
  var clicked: Bool = false
  var isSunday: Bool = false

  
  init(day: Int, clicked: Bool) {
    self.day = day
    self.clicked = clicked
  }
  
  var body: some View {
    VStack {
      Rectangle()
            .frame(width: 25, height: 25)
        .opacity(0)
        .overlay(Text(String(day)))
//        .foregroundColor(.black)
        .font(.pretendardMedium20)

//      if clicked {
//        Text("Click")
//          .font(.caption)
//          .foregroundColor(.red)
//      }
    }
  }
}

// MARK: - 내부 메서드
private extension CalenderView {
  /// 특정 해당 날짜
  private func getDate(for day: Int) -> Date {
    return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
  }
  
  /// 해당 월의 시작 날짜
  func startOfMonth() -> Date {
    let components = Calendar.current.dateComponents([.year, .month], from: month)
    return Calendar.current.date(from: components)!
  }
  
  /// 해당 월에 존재하는 일자 수
  func numberOfDays(in date: Date) -> Int {
    return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
  }
  
  /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
  func firstWeekdayOfMonth(in date: Date) -> Int {
    let components = Calendar.current.dateComponents([.year, .month], from: date)
    let firstDayOfMonth = Calendar.current.date(from: components)!
    
    return Calendar.current.component(.weekday, from: firstDayOfMonth)
  }
  
  /// 월 변경
  func changeMonth(by value: Int) {
    let calendar = Calendar.current
    if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
      self.month = newMonth
    }
  }
}

// MARK: - Static 프로퍼티
extension CalenderView {
  static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
  }()
  
  static let weekdaySymbols = Calendar.current.shortWeekdaySymbols
}

//#Preview {
//    CalenderView(month: Date(), startDate: $startDate, endDate: $endDate)
//}
