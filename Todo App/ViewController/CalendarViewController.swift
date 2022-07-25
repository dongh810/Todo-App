//
//  CalendarViewController.swift
//  Todo App
//
//  Created by 백동현 on 2022/07/02.
//
import Foundation
import UIKit
import FSCalendar
import Alamofire

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance,UITableViewDataSource
{
    
    //날짜 변수 선언
    var selectedDate = ""
    //전체 투두 리스트
    var allTodo: [Object] = []
    
    //이벤트 닷 출력
    var events: [String] = []
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        selectedDate = formatter.string(from: date)
        print(formatter.string(from: date) + " 선택됨")
        FindTodo()
        
    }
    func setUpEvents() {
        events.removeAll()
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "ko_KR")
//        formatter.dateFormat = "yyyy-MM-dd"
//        let xmas = formatter.date(from:"\(allTodo)")
//        let dots = allTodo
       // events.append(allTodo[0].date)
        print(events)
    
    }
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        let eventdot = formatter.string(from: date)
        if self.events.contains(eventdot) {
            return 1
        } else {
            return 0
        }
    }
    //이벤트 닷 위치
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        let eventScaleFactor: CGFloat = 1.3
        cell.eventIndicator.transform = CGAffineTransform(scaleX: eventScaleFactor, y: eventScaleFactor)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventOffsetFor date: Date) -> CGPoint {
        return CGPoint(x: 0, y: -7)
    }
    //테이블 뷰
    let df = DateFormatter()
    var dataSet: [object] = []
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ModifyViewController") as? ModifyViewController else {return}
        vc.modifyHead = dataSet[indexPath.row].title
        vc.modifyconctent = dataSet[indexPath.row].content
        vc.date = dataSet[indexPath.row].date
        self.navigationController?.pushViewController(vc, animated: true)
        print("fdfd")
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension //자동 높이 조절
    }
    
    @IBOutlet weak var myTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSet.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "a", for: indexPath) as! CustomTableViewCell
        
        cell.head.text = dataSet[indexPath.row].title
        cell.content.text = dataSet[indexPath.row].content
        
        return cell
    }
    
    //테이블뷰 새로고침
    func initRefresh() {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
        refresh.attributedTitle = NSAttributedString(string:"새로고침")
        
        if #available(iOS 10.0, *){
            myTableView.refreshControl = refresh
        }
        else{
            myTableView.addSubview(refresh)
        }
        
    }
    @objc func updateUI(refresh: UIRefreshControl) {
        refresh.endRefreshing()
        myTableView.addSubview(refresh)
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
        calendarView.appearance.eventDefaultColor = UIColor(red: 59/255, green: 130/255, blue: 246/255, alpha: 1)
        calendarView.appearance.eventSelectionColor = UIColor.white
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
        myTableView.dataSource = self
        setUpEvents()
        self.myTableView.reloadData()
        initRefresh()
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"
        selectedDate = formatter.string(from: date)
        
        
        
        
        
        //테이블 뷰
        let CustomTableViewCellNib = UINib(nibName: String(describing: CustomTableViewCell.self), bundle: nil)
        
        self.myTableView.register(CustomTableViewCellNib,forCellReuseIdentifier:"a")
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.rowHeight = UITableView.automaticDimension
        myTableView.estimatedRowHeight = 50
        
        
    }
    
    
    //조회 API
    func FindTodo() {
        let header :HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "userToken")!]
        let url = "http://15.164.102.4:3001/todo/\(selectedDate)"
        AF.request(url, method: .get, headers:header ).validate()
            .responseDecodable(of: FindTodoResponse.self){
                response in
                switch response.result{
                case.success(let response):
                    print(response.message)
                    print(response.data)
                    self.dataSet = response.data?.findedTodo ?? []
                    //print(self.dataSet)
                    
                    self.myTableView.reloadData()
                    
                    
                case.failure(let error):
                    print("\(error.localizedDescription)")
                }
            }
    }
    //전체 투두 조회 API
    func FindAllTodo() {
        let header :HTTPHeaders = ["Authorization": UserDefaults.standard.string(forKey: "userToken")!]
        let url = "http://15.164.102.4:3001/todo"
        AF.request(url, method: .get, headers: header).validate().responseDecodable(of: FindAllTodoResponse.self){
            response in
            switch response.result{
            case.success(let response):
                print(response.message)
                //self.allTodo = response.data?.findedAllTodo ?? []
                print(self.allTodo)
                self.setUpEvents()
                self.calendarView.reloadData()
            case.failure(let error):
                print("\(error.localizedDescription)")
            }
        }
        
    }
    
    
    
}
extension CalendarViewController: UITableViewDelegate{
    
    
    
    
}

