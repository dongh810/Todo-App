//
//  CalendarViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/02.
//
import Foundation
import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance,UITableViewDataSource
{
//    var events: [Date] = []
//
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//           print(dateFormatter.string(from: date) + " 선택됨")
//       }
//    func setUpEvents() {
//        events.removeAll()
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "yyyy-MM-dd"
//        let xmas = formatter.date(from: "2022-07-25")
//        let sampledate = formatter.date(from: "2020-08-22")
//        events = [xmas!, sampledate!]
//    }
//    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
//            if self.events.contains(date) {
//                return 1
//            } else {
//                return 0
//            }
//        }
    let df = DateFormatter()
    let headdata = ["one","two","three","four","five"]
    let contentdata = ["일","이","삼","사","오"]
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ModifyViewController") as? ModifyViewController else {return}
        vc.modifyHead = headdata[indexPath.row]
        vc.modifyconctent = contentdata[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        print("fdfd")
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    @IBOutlet weak var myTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.headdata.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "a", for: indexPath) as! CustomTableViewCell
        
        cell.head.text = headdata[indexPath.row]
        cell.content.text = contentdata[indexPath.row]
        
        return cell
    }
    
    
    
   
    // 네비게이션 전환 코드
    @IBAction func plusBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Sub", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
   
    
    //캘린더
    var eventsArray = [Date]()
    @IBOutlet var calendarView: FSCalendar!{
        didSet{
            calendarView.delegate = self
            calendarView.dataSource = self
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        df.locale = Locale(identifier: "ko_KR")
        df.dateFormat = "yyyy년 M월"
        return df
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCalendar()
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        /* 테이블 사이즈 알아서 조절
         self.tableView.estimatedRowHeight = 50
         self.tableView.rowHeight = UITableViewAutomaticDimension
         */
    }
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    
    private func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
    
    
    func setCalendar() {
        calendarView.delegate = self
        calendarView.delegate = self
        calendarView.headerHeight = 0
        calendarView.scope = .month
        dateLabel.text = self.dateFormatter.string(from: calendarView.currentPage)
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.dateLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //캘린더
        calendarView.weekdayHeight = 16    // 날짜 표시부 행의 높이
        calendarView.appearance.headerMinimumDissolvedAlpha = 0.0    //헤더 좌,우측 흐릿한 글씨 삭제
        calendarView.placeholderType = .none
        dateLabel.font = UIFont(name: "Inter-SemiBold", size: 18)
        calendarView.scrollEnabled = true
        calendarView.calendarHeaderView.isHidden = true
        calendarView.backgroundColor = .white   // 배경색
        calendarView.appearance.weekdayTextColor = UIColor(red: 113/255, green: 113/255, blue: 122/255, alpha: 1) //요일(월,화,수..) 글씨 색
        calendarView.appearance.selectionColor = UIColor(red: 59/255, green: 130/255, blue: 246/255, alpha: 1) //선택 된 날의 동그라미 색
        calendarView.appearance.titleWeekendColor = .black //주말 날짜 색
        calendarView.appearance.titleDefaultColor = .black //기본 날짜 색
        
        calendarView.appearance.titleTodayColor = .none         //Today에 표시되는 특정 글자색
        calendarView.appearance.todayColor = .none         //Today에 표시되는 선택 전 동그라미 색
        calendarView.appearance.todaySelectionColor = .none//Today에 표시되는 선택 후 동그라미 색
        calendarView.appearance.eventDefaultColor = UIColor.black
        calendarView.appearance.eventSelectionColor = UIColor.black
    
        calendarView.appearance.titleFont = UIFont(name: "Inter-SemiBold", size: 10)
        calendarView.appearance.weekdayFont = UIFont(name: "Inter-SemiBold", size: 10)
        calendarView.calendarWeekdayView.weekdayLabels[0].text = "SUN"
        calendarView.calendarWeekdayView.weekdayLabels[1].text = "MON"
        calendarView.calendarWeekdayView.weekdayLabels[2].text = "TUE"
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "WED"
        calendarView.calendarWeekdayView.weekdayLabels[4].text = "THU"
        calendarView.calendarWeekdayView.weekdayLabels[5].text = "FRI"
        calendarView.calendarWeekdayView.weekdayLabels[6].text = "SAT"
        
        calendarView.dataSource = self
        calendarView.delegate = self
   
                
        
        //테이블 뷰
        let CustomTableViewCellNib = UINib(nibName: String(describing: CustomTableViewCell.self), bundle: nil)
        
        self.myTableView.register(CustomTableViewCellNib,forCellReuseIdentifier:"a")
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 120
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.rowHeight = UITableView.automaticDimension
       
       
    }
  
   
}
extension CalendarViewController: UITableViewDelegate{
    

    
}


