//
//  CalendarViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/02.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    
   
    @IBOutlet var calendarView: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
  
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
    
       
            
        
        
        
        
        
        calendarView.headerHeight = 20
        // YYYY년 M월 표시부 영역 높이
        
        calendarView.weekdayHeight = 60
        // 날짜 표시부 행의 높이
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0
        //헤더 좌,우측 흐릿한 글씨 삭제
        calendarView.appearance.headerDateFormat = "YYYY년 MM월" //날짜(헤더) 표시 형식
        let formatter = DateFormatter() //객체 생성
        let now = Date()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        let calendar = Calendar.current
        
        formatter.dateFormat = "YYYY년 MM월" //데이터 포멧 설정
        let str = formatter.string(from: Date())//문자열로 바꾸기
        dateLabel.text = "\(calendar.component(.year, from: now))"
        dateLabel.text = "\(str)"   //라벨에 출력
        dateLabel.font = UIFont(name: "Roboto-Medium", size: 18)
        calendarView.scrollEnabled = true
        
        
        
        
        
        calendarView.appearance.headerTitleColor = .white //2021년 1월(헤더) 색
        calendarView.appearance.headerTitleFont = UIFont(name: "Roboto-Medium", size: 18)
        //타이틀 폰트 크기
        
        calendarView.backgroundColor = .white // 배경색
        calendarView.appearance.weekdayTextColor = .black //요일(월,화,수..) 글씨 색
        calendarView.appearance.selectionColor = .blue //선택 된 날의 동그라미 색
        calendarView.appearance.titleWeekendColor = .black //주말 날짜 색
        calendarView.appearance.titleDefaultColor = .black //기본 날짜 색
        
        calendarView.appearance.titleTodayColor = .none
        //Today에 표시되는 특정 글자색
        calendarView.appearance.todayColor = .none
        //Today에 표시되는 선택 전 동그라미 색
        calendarView.appearance.todaySelectionColor = .none
        //Today에 표시되는 선택 후 동그라미 색
        
        
        calendarView.appearance.titleFont = UIFont(name: "Roboto-Medium", size: 11)
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "SUN"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "MON"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "TUE"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "WED"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "THU"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "FRI"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "SAT"
        
       
        
      
        
        

        
               
       
        
        
        
       

        

        
        }
    
 
    

}
